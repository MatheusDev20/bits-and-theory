## CLOUD Concepts (24%)

## Definition
   AWS is a Cloud service provider launched in 2006

## History
  Started as a Cloud provider in 2006.
  First product ( S3 Storage service and SQS After )
  Worlds leader cloud plataform


## 🌐 Global Infrastructure

AWS’s infrastructure is globally distributed and organized in the following layers:

### 📍 Region
- A geographic area that contains **two or more Availability Zones (AZs)**.
- Example: `us-east-2` (Ohio).
- Designed for **fault tolerance and high availability**, since multiple datacenters back each region.

### 🏢 Availability Zones (AZs)
- One or more **data centers** within a region.
- Each AZ is isolated but connected with **low-latency links** to others.
- Ensures **redundancy and high availability** in case one AZ goes down.

### 🌎 Edge Locations
- Used by **Amazon CloudFront** and other services to **cache content closer to users**.
- Improves **latency and performance** by serving content from the nearest location.
- Part of AWS’s **Content Delivery Network (CDN)**.



## AWS Shared Responsibility Model

This model defines the responsibilities of AWS and the customer when using AWS services.

- **AWS is responsible for "Security *of* the cloud":**
  - Physical security of data centers
  - Network infrastructure and hardware maintenance
  - Host OS security patches
  - Underlying services like Lambda, DynamoDB, S3

- **Customer is responsible for "Security *in* the cloud":**
  - Configuration of the guest OS (EC2, RDS, etc.)
  - Application-level security (encryption, firewall rules)
  - IAM (users, groups, roles, policies)
  - Data protection and backups
  - Network setup (e.g., VPC, subnets, route tables, NACLs)

🔑 **Mnemonics:**
- “**OF the cloud**” → AWS cuida
- “**IN the cloud**” → Você cuida




