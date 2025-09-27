# AWS Small Services – Cheat Sheet

Quick reference for less-common but test-relevant AWS services.

---

## 🛡️ Security & Compliance
- **AWS Certificate Manager (ACM)** – Manages **SSL/TLS certificates** for securing traffic to AWS resources (e.g., ALB, CloudFront).
- **Amazon Macie** – **Automated security** and **data privacy** service that discovers & classifies **sensitive data** (like PII) in S3.
- **AWS Trusted Advisor** – Gives **recommendations** for **cost optimization, performance, security, fault-tolerance, and service limits**.
- **AWS Anomaly Detection (Cost)** – Uses **ML to detect unusual AWS spending patterns**.
- **AWS CloudFormation** - Bootstrap AWS Services in a common language to create resources ( remember IAC terraform )
---

## 🗄️ Migration & Hybrid Cloud
- **AWS Application Migration Service (AWS MGN)** – “**Lift-and-shift**” migration of **apps & servers** from on-premises to **EC2**.
- **AWS Database Migration Service (AWS DMS)** – Migrates **databases** to AWS with minimal downtime.
- **AWS Site-to-Site VPN** – Creates an **encrypted network tunnel** between **on-premises** data centers and AWS VPC.
- **Hybrid Cloud** – Combines **on-premises IT** with **cloud resources**, often via **VPN/Direct Connect** for a seamless hybrid environment.
- **AWS Systems Manager** - Manage services running onPremise and on AWS through a single interface
- **AWS CodeDeploy** Automates code deployments to any instances (OnPremises and EC2 running on AWS )
- **AWS Partner Networking Partners** 
      (APN Consulting) ->  Focused  Helping partners building AAWS based businses on AWS
      (APN Techology) -> Focused on selling and provided ready aws services ( SaaS , PaaS)
---

## 💻 Compute & Optimization
- **EC2 Spot Instances** – **Low-cost EC2 capacity** using unused AWS compute; can be interrupted if demand rises.
- **Elastic Fabric Adapter (EFA)** – **High-performance network interface** for EC2, supports **HPC** and **low-latency, high-throughput** workloads.
- **AWS Compute Optimizer** – Analyzes **usage patterns** to **right-size** EC2, EBS, and Lambda for **cost savings** and efficiency.
- **EC2 Image Builder** - Automates the testing, deployment management of EC2 server images

---

## 🗂️ Storage & AI/ML
- **Amazon Polly** – Converts **text to natural-sounding speech (TTS)**.
- **Amazon Redshift ML** – Lets you **train and run ML models directly in Redshift** using **SQL on data warehouse datasets**.
- **Amazon S3 Glacier Flexible Retrieval** Lowest cost amazon S3 Storage, storage large ammounts and fast retrieval

---

## 💼 Developer & Marketplace
- **AWS Code* Services (CodeCommit, CodeBuild, CodeDeploy, CodePipeline)** – Suite of tools for **CI/CD pipelines**.
- **AWS Marketplace** – Online store to **buy or sell software** built by AWS partners and deploy it easily on AWS.

---

## 🔑 Key Notes
- Focus on **service purpose & use case**, not deep configuration.
- Pay attention to keywords: **“encrypted connection” → VPN/ACM**, **“lift-and-shift” → MGN**, **“detect PII in S3” → Macie**.


## Billing   
- **AWS Billing Conductor** - Manage billing separatedly for diferent organizations

## Regional Services
- **AWS Batch** - Running Batches across multiples AZs
- **AWS EFS** - Store data across multiples AZs