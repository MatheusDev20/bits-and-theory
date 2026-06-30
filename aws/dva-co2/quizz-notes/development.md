# DVA-C02 — Development Notes

> Quick-reference cheat sheet for the AWS Developer Associate exam.

---

## ECS

### Placement Strategy
- **Spread** — place tasks evenly.
- **Random** — place tasks randomly.
- **Binpack** — place tasks on the instance with the least available CPU/memory (packs tightly to save cost).

### Task Definition
The blueprint for a task → image, CPU/memory, network mode, port mappings.

**Port mapping (Docker)** — maps `containerPort` → `hostPort` so traffic reaches the container.
- `bridge` mode + `hostPort = 0` → **dynamic port mapping**: ECS picks a random host port.
  - Lets you run **many copies** of the same container on one EC2 host (no port clash).
  - The ALB target group tracks those dynamic ports automatically.
- `awsvpc` mode → each task gets its own ENI/IP; `containerPort` is the port (no host port needed).

**Long-lived connections** — put a load balancer in front of the service.
- **NLB** preferred for long-lived/sticky TCP (WebSockets, gRPC, low latency).
- **Deregistration delay** (connection draining) lets in-flight connections finish before a task stops.

---

## DynamoDB

### GSI (Global Secondary Index)
- Lets you specify a **different PK** from the base table (string, number, or binary).
- Up to **20** indexes.
- Queries/scans consume capacity from the **index**, not the base table.
- **Eventual consistency** only.

### LSI (Local Secondary Index)
- Can choose **strong** or **eventual** consistency.

---

## API Gateway

- **Integration Request** — configures the mapping of query params.
- **Mapping Templates** — **Stage Variables** can be defined per stage (Dev / Prod) and passed via mapping templates.

### Integration Types
How API Gateway passes a request to the backend.

- **Lambda Proxy** (`AWS_PROXY`) — easiest. The whole request (headers, query, body) is passed to Lambda as-is; Lambda returns a fixed JSON shape (`statusCode`, `headers`, `body`). No mapping templates.
- **Lambda Custom** (`AWS`) — you control the integration with **mapping templates** (VTL) to transform request → Lambda and Lambda → response. More setup, more flexibility.
- **HTTP Proxy** (`HTTP_PROXY`) — simple passthrough to a backend HTTP endpoint; no transformation, easy setup.
- **HTTP Custom** (`HTTP`) — forward to an HTTP backend but reshape the request/response with mapping templates.
- **AWS Service** — call an AWS service directly (e.g. put a message to SQS, write to DynamoDB) without a Lambda in between.
- **Mock** — return a response from API Gateway itself, no backend (useful for testing / CORS).

**Proxy vs Custom rule of thumb:** *Proxy* = passthrough, no mapping, simplest. *Custom* (non-proxy) = use mapping templates to transform data.

---

## AppSync

- Combines data from one or more **data sources**.
- Uses **GraphQL**.
- Can be used in **real time**.

---

## CloudFront

**Lambda@Edge** — customize the content CloudFront delivers and run functions close to the viewers.

### Geo-based routing / redirects (quiz)
- Use a **CloudFront Function** that returns the right URL based on the **`CloudFront-Viewer-Country`** header.
- Trigger it on the **Viewer Request** event.
- **CloudFront Functions** — lightweight JS, run at edge locations, sub-ms, ideal for header/URL rewrites & redirects (cheaper/faster than Lambda@Edge).
- Only fire on **Viewer Request / Viewer Response** events (not Origin events).
- `CloudFront-Viewer-Country` is a CloudFront-added header giving the viewer's 2-letter country code → great for geo-routing without hitting the origin.

---

## Kinesis Data Stream

- Streaming data.
- **Split shards** → increase capacity and cost.
- **Merge shards** → reduce capacity and cost.
- For lambda consuming shards the concurrent execution is at least the number of shards (100 shards at most 100 c.e)

---

## Cognito

**Cognito Sync** — sync user profile data across applications.

### User Pools — *Authentication* ("Who are you?")
- A user **directory** / identity provider → sign-up and sign-in for your app users.
- Returns **JWT tokens** (ID, Access, Refresh) after a successful login.
- Built-in: MFA, email/phone verification, password policies, account recovery.
- Federation with external IdPs (Google, Facebook, Apple, SAML, OIDC) → still returns a Cognito User Pool token.
- Integrates with API Gateway and ALB as an **authorizer** (validates the JWT).
- Use it when you need to **manage the users** themselves (the login screen).

### Identity Pools (Federated Identities) — *Authorization* ("What can you access?")
- Provide **temporary AWS credentials** (via STS) to access AWS services directly (S3, DynamoDB, etc.).
- Exchange an identity token for an **IAM role** → credentials scoped by that role.
- Identity sources: a Cognito User Pool, external IdPs, or guest/unauthenticated users.
- Supports **authenticated** and **unauthenticated (guest)** roles → guest access without sign-in.
- Use it when your app needs to **call AWS services** on behalf of the user.

### User Pool vs Identity Pool

| | User Pool | Identity Pool |
|---|---|---|
| **Purpose** | Authentication (login) | Authorization (AWS access) |
| **Gives you** | JWT tokens | Temporary AWS credentials (STS) |
| **Use when** | You manage the users / login | App calls AWS services for the user |

**How they work together:** sign in to a User Pool → get a JWT → pass it to an Identity Pool → get temporary AWS credentials → call AWS services.

**Independently:**
- *User Pool alone* → auth for an app that only talks to your own backend / API Gateway.
- *Identity Pool alone* → grant AWS access from a third-party IdP or guests, no User Pool needed.

---

## Elastic Beanstalk

- **PaaS** — upload your code, AWS handles the infra (EC2, ASG, ELB, capacity, health).
- You stay in control: full access to the underlying resources, but managed for you.
- **Free service** — you only pay for the underlying resources it creates.
- Platforms: Node, Python, Java, .NET, PHP, Ruby, Go, Docker.
- Components: **Application → Environment → Version → Configuration**.
- **Web tier** (handles HTTP) vs **Worker tier** (processes SQS messages / background jobs).

### Environment Tiers
- **Web Server tier** — serves HTTP requests behind an ELB.
- **Worker tier** — pulls from an **SQS** queue to process background jobs; use **`cron.yaml`** for periodic tasks.

### Config Files (in the source bundle)
- **`.ebextensions/*.config`** (YAML/JSON) — customize the environment & resources (`option_settings`, packages, files, commands). Lives in the bundle root.
- **`cron.yaml`** — periodic tasks for a **worker** environment (cron schedule → auto-pushes jobs onto the worker's SQS queue).
- **`Dockerrun.aws.json`** — config for Docker platform (image, ports).
- **`.platform/`** hooks — newer way to run scripts at platform lifecycle stages (replaces some `.ebextensions` use).

### Deployment Policies
- **All at once** — fastest, but downtime.
- **Rolling** — deploy in batches, no extra cost (reduced capacity during deploy).
- **Rolling with additional batch** — keeps full capacity (spins up extra instances).
- **Immutable** — deploy to brand-new instances; safest, easy rollback.
- **Blue/Green** — deploy to a **separate environment**, then **swap CNAME** (URL swap) → zero downtime, instant rollback. *Not* a deployment-policy dropdown — you do it by cloning + swapping.

### IAM: two roles (easy to confuse)
- **Instance profile** (`aws-elasticbeanstalk-ec2-role`) — what the **EC2 instances** can do. Already includes web/worker tier perms; add **`AWSXRayDaemonWriteAccess`** to run the X-Ray daemon, `AmazonS3ReadOnlyAccess`, SQS perms, etc.
- **Service role** — what **Beanstalk itself** uses to manage/monitor the environment (enhanced health).

### X-Ray on Beanstalk
- Enable the daemon via console (**Configuration → Software → X-Ray enabled**) or `.ebextensions`:
  ```yaml
  option_settings:
    aws:elasticbeanstalk:xray:
      XRayEnabled: true
  ```
- The instance profile must allow X-Ray writes → managed policy **`AWSXRayDaemonWriteAccess`** (`xray:PutTraceSegments`, `xray:PutTelemetryRecords`).

### Gotchas
- **RDS launched inside an EB environment** is tied to its lifecycle → terminating the env **deletes the DB**. For prod, create RDS **separately** and connect via env vars.
- **Health**: *Basic* (CloudWatch metrics) vs *Enhanced* (per-instance health, more detail — needs the service role).

---

## CI/CD (Developer Tools)

**Quick map:** CodeBuild = build · CodeDeploy = deploy · CodePipeline = orchestrate.

### CodeCommit
- Git repository hosted on AWS (the **source** step).
- *Note: being deprecated, but still on the exam.*

### CodeBuild — *Build*
- Compiles source, runs tests, produces deployable artifacts.
- Instructions in **`buildspec.yml`** (root of your code).
- Fully managed, pay per build minute, output stored in S3.

### CodeDeploy — *Deploy*
- Automates pushing your app to EC2, on-prem, Lambda, or ECS.
- Instructions in **`appspec.yml`**.
- Deployment types:
  - **In-place** — updates existing instances (EC2/on-prem only).
  - **Blue/Green** — new instances, then shift traffic (safe rollback).
- Lambda/ECS traffic shifting: **Canary, Linear, All-at-once**.

### CodePipeline — *Orchestrate*
- Automates the full release flow: **Source → Build → Test → Deploy**.
- Glues the other services together (CodeCommit / CodeBuild / CodeDeploy + more).
- Made of **Stages** → each stage has **Actions**; artifacts pass between stages via S3.
- Can trigger on source changes (CloudWatch Events / webhooks).

### Lambda

  - Default concurrent limit (1000)
  - Unreserved execution limit cannot go down than 100

