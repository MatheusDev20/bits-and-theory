# DVA-C02 — Troubleshooting Notes

> Things that break and how to spot them in exam questions.

---

## X-Ray

What it is: **distributed tracing** — follow a request as it hops across services to find latency and errors.

- The **X-Ray daemon** listens on **UDP port 2000** — used to debug Docker containers inside ECS.
- **Traces** = end-to-end request; **Segments** = work done by one service; **Subsegments** = granular calls (e.g. a DynamoDB call); **Annotations** = indexed key/values you can filter on; **Metadata** = not indexed.
- Sampling reduces cost — not every request is traced.

**Lambda ↔ X-Ray environment variables (exam — know these two):**
- **`_X_AMZN_TRACE_ID`** — carries the **tracing header / trace ID** for the current invocation (so segments link together).
- **`AWS_XRAY_CONTEXT_MISSING`** — what to do when no trace context is found; defaults to **`LOG_ERROR`**.
- (Also real: `AWS_XRAY_DAEMON_ADDRESS` = daemon IP:port.)
- ❌ Not real / distractors: `AWS_XRAY_DEBUG_MODE`, `AUTO_INSTRUMENT`, `AWS_XRAY_TRACING_NAME` (the last is an X-Ray **SDK** var, not a Lambda-managed one).

**Common "X-Ray not working" causes (exam favorites):**
- **Missing IAM permissions** — the role needs `AWSXRayDaemonWriteAccess` (`xray:PutTraceSegments`, `xray:PutTelemetryRecords`).
- **EC2** → install the daemon + give the instance role X-Ray write perms.
- **Lambda** → enable **Active Tracing** + grant the function X-Ray write perms (no daemon needed, AWS runs it).
- **ECS** → run the X-Ray daemon as its own container (sidecar) in the task definition.
- Beanstalk → enable X-Ray in the environment config.

---

## API Gateway

- **Integration timeout = 29 seconds** (max). If Lambda or an `HTTP`/`HTTP_PROXY` backend hangs longer → **504 Gateway Timeout**.
- **CORS errors** ("blocked by CORS policy") → enable **CORS** on the API; for proxy integrations the **headers must be returned by the backend**. Preflight = browser sends `OPTIONS`.
- **429 Too Many Requests** → throttling: account/stage/usage-plan rate & burst limits exceeded.
- **403** → could be a missing **API key**, a resource policy, or WAF block. **401/403 Unauthorized** → authorizer (Cognito / Lambda authorizer) rejected the token.
- **5xx from API Gateway** = backend issue (502 bad response shape, 503 unavailable, 504 timeout). **4xx** = client/config issue.
- Stale changes? → you must **redeploy to a stage** for changes to take effect.

---

## Lambda

- **Throttling / 429 (`TooManyRequestsException`)** → hit the concurrency limit. Default account limit **1000** concurrent; reserved concurrency caps a function.
- **Task timed out** → execution exceeded the configured timeout (max **15 min**).
- **`AccessDenied`** at runtime → the **execution role** is missing permissions for the AWS call.
- **CloudWatch Logs empty** → the role lacks `logs:CreateLogGroup/CreateLogStream/PutLogEvents` (managed policy `AWSLambdaBasicExecutionRole`).
- **Can't reach RDS / internet** → Lambda is in a **VPC** with no route (needs NAT gateway for internet, or VPC endpoints).
- **Cold starts** → high latency on first invoke → use **Provisioned Concurrency**.

**⭐ Lambda in a VPC loses internet access (very common exam question):**
- Putting a function **inside a VPC removes default internet access** — it can reach private resources (RDS, etc.) but **not** the public internet.
- To restore internet (call a public API, etc.):
  - Run the function in a **private subnet**.
  - Add a **NAT Gateway** in a **public subnet** (which has an Internet Gateway).
  - Point the private subnet's route table `0.0.0.0/0` → the **NAT Gateway**.
- Lambda attaches to the VPC via **Elastic Network Interfaces (ENIs)** — these are how it talks to resources in the private VPC.
- To reach **AWS services privately** (S3, DynamoDB) without a NAT → use **VPC Endpoints** (cheaper, no internet).
- ❌ A public subnet + IGW alone does **not** work for Lambda — Lambda ENIs have **no public IP**, so it must go out via NAT.

---

## VPC

**VPC Flow Logs** — capture info about IP traffic going **to and from network interfaces** (ENIs). Sent to CloudWatch Logs or S3.
- Use them to debug **why traffic is blocked** — `ACCEPT` vs `REJECT` in the log tells you if an SG/NACL dropped it.
- They log **metadata only** (src/dst IP, ports, action) — **not packet contents**.

**Connectivity troubleshooting:**
- **Security Groups** = stateful, allow rules only (return traffic auto-allowed).
- **NACLs** = stateless, allow **and** deny, evaluated by rule number — must allow **return/ephemeral ports** explicitly.
- No internet from a private subnet → needs a **NAT Gateway**; public subnet needs an **Internet Gateway** + public IP.

---

## CloudTrail

What it is: **records API calls / account activity** — *who did what, when, from where* (auditing & governance).

- Answers "**who deleted/changed this resource?**" → look in CloudTrail. (vs CloudWatch = metrics/logs/performance.)
- **Management events** (control-plane, e.g. `RunInstances`) on by default; **Data events** (e.g. S3 object-level, Lambda invokes) are opt-in and high-volume.
- Events typically appear within ~**15 minutes**; **Event history** keeps the last **90 days** for free — create a **Trail** to keep longer (to S3).
- "Why did permission fail / who assumed this role" → CloudTrail shows the API caller and `errorCode` (e.g. `AccessDenied`).

---

## Quick "which service?" map
- *Trace a slow request across services* → **X-Ray**
- *Who made this API call / changed a resource* → **CloudTrail**
- *Metrics, logs, alarms, performance* → **CloudWatch**
- *Why is network traffic blocked* → **VPC Flow Logs**
