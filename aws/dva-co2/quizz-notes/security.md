# DVA-C02 — Security Domain (Quiz Notes)

## AWS Secrets Manager
- Stores secrets (DB credentials, API keys) **encrypted at rest with KMS**.
- Can enable **automatic rotation** of secrets (native integration for RDS, Redshift, DocumentDB; Lambda for others).
- Use it over SSM Parameter Store when you need built-in rotation and cross-account/secret-sharing features.

## IAM

### Roles
- Provide **temporary credentials** to services (e.g. EC2, Lambda) instead of long-lived access keys.
- Attaching a role to a service is the recommended way to grant **least-privilege** access to only the AWS resources it needs.
- Credentials are delivered via **STS** and rotated automatically.

### Troubleshooting policies
- **IAM Policy Simulator** evaluates and tests policies to see whether an action would be allowed/denied before applying them.

## S3

### Server-side encryption (SSE)
| Type | Key managed by | Request header(s) |
|------|----------------|-------------------|
| **SSE-S3** | AWS (AES-256) | `x-amz-server-side-encryption: AES256` |
| **SSE-KMS** | AWS KMS (default or customer CMK) | `x-amz-server-side-encryption: aws:kms` |
| **SSE-C** | Customer-provided key | see headers below |

**SSE-C** requires sending the key with every request (Amazon never stores it):
- `x-amz-server-side-encryption-customer-algorithm` → must be `AES256`.
- `x-amz-server-side-encryption-customer-key` → 256-bit, base64-encoded key used to encrypt/decrypt the object.
- `x-amz-server-side-encryption-customer-key-MD5` → base64-encoded MD5 of the key (integrity check).

> SSE-C requests **must use HTTPS** — S3 rejects plaintext HTTP when a customer key is supplied.

### AWS CLI with S3
- Automatically performs **multipart upload** when a file is large.
- To `aws s3 cp` with **SSE-KMS**, the developer's identity needs `kms:GenerateDataKey` (upload/encrypt) and `kms:Decrypt` (download/decrypt) on the key.

## Accessing AWS resources from outside (on-premises)
- Use an **IAM user with an access key**, configured in `~/.aws/credentials` on the on-prem host.
- You **cannot** use an IAM role via `sts:AssumeRole` directly from on-prem the way EC2 does (no instance metadata / instance profile available).
  - (Modern alternative not always in older quizzes: **IAM Roles Anywhere** with X.509 certs enables role-based temp creds on-prem.)

## CloudFormation

### Secure parameters in a template
- Declare the parameter as **`SecureString`** and resolve it from **SSM Parameter Store** using `ssm-secure`:
```yaml
LoginProfile:
  Password: '{{resolve:ssm-secure:IAMUserPassword:10}}'
```
- `10` is the parameter **version**. This keeps secrets out of the template/source control.

## API Gateway

### Lambda Authorizers
- **Token-based (`TOKEN`)** → verifies identity from a bearer token (JWT, OAuth) in a header.
- **Request-parameter-based (`REQUEST`)** → builds identity from headers, query string params, path params, and `$context` variables.

## Encryption with AWS KMS

### Envelope encryption
The pattern KMS uses so you never encrypt large data directly with the KMS key:

1. The **KMS Key (CMK / root key)** never leaves KMS unencrypted — it's the master key.
2. You call **`GenerateDataKey`**, which returns a **data key** in two forms:
   - **Plaintext data key** → used locally to encrypt your actual data.
   - **Encrypted (ciphertext) data key** → the same data key, encrypted by the CMK.
3. Encrypt the data with the plaintext data key, then **discard the plaintext key** from memory.
4. Store the **encrypted data key alongside the ciphertext data**.
5. To decrypt: send the encrypted data key to KMS (**`Decrypt`**), KMS returns the plaintext data key, you decrypt the data, then discard the plaintext key again.

**Why:** asymmetric/symmetric calls to KMS are limited to small payloads (≤4 KB) and add latency; envelope encryption lets you encrypt arbitrarily large data locally while the small data key is the only thing KMS protects.

Key permissions to remember:
- `kms:GenerateDataKey` → get a data key to encrypt.
- `kms:Decrypt` → unwrap the encrypted data key to decrypt.
- `kms:Encrypt` → encrypt small (≤4 KB) data directly with the CMK.

## AWS CloudHSM
- Provides **dedicated, single-tenant Hardware Security Module (HSM)** appliances in your VPC for key generation and crypto operations.
- **You** manage the keys and users — AWS manages only the hardware. AWS **cannot** access or recover your keys (so if you lose them, they're gone).
- **FIPS 140-2 Level 3** validated → use it when compliance requires a dedicated HSM and full customer control of keys.

### CloudHSM vs KMS (exam contrast)
| | **KMS** | **CloudHSM** |
|---|---------|--------------|
| Tenancy | Multi-tenant, managed | Single-tenant, dedicated hardware |
| Key control | AWS-managed service, you control usage | You fully own/manage keys |
| FIPS level | 140-2 Level 3 (shared) | 140-2 Level 3 (dedicated) |
| Access | AWS API/SDK | Industry-standard **PKCS#11**, JCE, CNG/KSP |
| Use case | Default AWS encryption integration | Strict compliance, custom key store |

- Can back KMS via a **Custom Key Store**: KMS keys live in your CloudHSM cluster while keeping KMS API integration.
- Runs in **at least 2 AZs (a cluster)** for high availability and automatic load balancing/sync.

## SSL/TLS Certificates (ACM)
- **AWS Certificate Manager (ACM)** provisions, manages, and renews SSL/TLS certs. ACM-issued (public) certs **auto-renew**; **imported** certs do **not** — you must re-import before expiry.
- You can **import third-party certs** into ACM, but they can only be attached to services that integrate with ACM.

### Services that can use ACM certificates
- **Elastic Load Balancing (ALB / NLB / CLB)**
- **Amazon CloudFront**
- **API Gateway**
- **AWS App Runner**, **Amazon Cognito**, **Elastic Beanstalk** (via the ELB it provisions)

> **Exam trap:** ACM certificates **cannot be installed directly on EC2 instances** or on-prem servers — you must export the cert (only possible with **ACM Private CA**) or store it in **IAM certificate store** and install it manually.

### Regional gotcha
- For **CloudFront**, the ACM cert **must be in `us-east-1`** regardless of where your other resources live.
- For ALB/NLB/API Gateway, the cert must be in the **same region** as the resource.

### IAM certificate store
- The **legacy/fallback** place to upload SSL/TLS server certs when **ACM isn't available** in your region or for the target service.
- Upload with the CLI: `aws iam upload-server-certificate` (provide cert body, private key, and chain).
- Can be attached to **ELB** and **CloudFront** (the main services that read certs from IAM).
- Trade-offs vs ACM:
  - **No auto-renewal** — you manage expiry and re-upload manually.
  - **No console management UI** — managed via CLI/API only.
  - You **can't retrieve the private key** back after upload.
- **Rule of thumb:** prefer **ACM**; use the IAM certificate store only when ACM doesn't support your region/service.

### Cognito

1 - Can have MFA attached to a specific user pool