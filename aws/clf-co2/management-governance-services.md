# AWS Organizations, Resource Groups, IAM, and AWS Config – Cheat Sheet

---

## 🏢 AWS Organizations
A **centralized account management service** that lets you **organize and govern** multiple AWS accounts at scale.

- **Key Features:**
  - **Consolidated Billing:** Combine bills from all member accounts → leverage **volume discounts** and simplify payment.
  - **Centralized Management:** Manage multiple **teams, projects, or departments** under one umbrella (the **management account**).
  - **Service Control Policies (SCPs):** Apply **permission boundaries** across member accounts (e.g., deny certain regions or services).
  - **Organizational Units (OUs):** Group accounts logically (e.g., `Dev`, `Prod`, `Finance`) to apply policies more easily.
  - **Account Governance:** Enforce compliance and security controls at scale.

- **Benefits:**
  - Easier **cost tracking** and **budget control**.
  - **Centralized security and compliance** enforcement.
  - Scales well for **enterprises and multi-team environments**.

---

## 🗂️ AWS Resource Groups
Allows you to **organize and manage AWS resources** across Regions and services.

- **Key Features:**
  - Create **collections of resources** (e.g., Lambda functions, S3 buckets, RDS instances) that share **tags or criteria**.
  - Manage or apply actions **at the group level** rather than resource-by-resource.
  - Supports **shared or partial tags** to quickly identify resources (e.g., `Project:Analytics`).

- **Use Cases:**
  - Manage all resources for a specific **project, application, or environment**.
  - Apply **bulk actions** like tagging, viewing metrics, or monitoring.

---

## 👤 IAM User
An **identity within AWS IAM** that represents a **person or application** needing access to AWS.

- **Key Points:**
  - Each user has:
    - **Credentials for the Console:** username + password.
    - **Programmatic Access:** **Access Key ID** + **Secret Access Key** for CLI/SDK/API calls.
  - Assigned **permissions via IAM Policies** (attached directly or via groups).
  - Follows **least-privilege principle**: grant only the permissions needed.

- **Best Practices:**
  - Avoid using the **root account** for daily operations.
  - Enforce **MFA (Multi-Factor Authentication)**.
  - Rotate **access keys** regularly.
  - Use **roles** for apps/services instead of embedding static keys.

---

## ⚙️ AWS Config
A **configuration management and compliance assessment service** for AWS resources.

- **Key Features:**
  - **Monitors and records** the configuration of AWS resources over time.
  - **Evaluates compliance** against desired settings (e.g., “S3 buckets must be encrypted”).
  - Provides **detailed change history** for each resource.
  - Enables **automatic remediation** for non-compliant resources.

- **Use Cases:**
  - Maintain **security & compliance posture** (e.g., HIPAA, PCI-DSS).
  - **Audit and troubleshoot** changes in environments.
  - Support **governance and best practices** enforcement.

---

## 🟢 Exam Quick Mapping

| Service            | Core Purpose                           |
|--------------------|---------------------------------------|
| **AWS Organizations** | Manage multiple accounts centrally, billing + policies |
| **AWS Resource Groups** | Group and manage resources by tags/criteria |
| **IAM User**          | Human or programmatic access to AWS resources |
| **AWS Config**        | Monitor configurations & enforce compliance |

---

## 🔑 Exam Tips
- **Organizations** → think **multi-account management** & **SCPs**.  
- **Resource Groups** → **tag-based grouping** for easy management.  
- **IAM User** → avoid root; use **least privilege + MFA**.  
- **AWS Config** → **compliance, auditing, and config history**.

