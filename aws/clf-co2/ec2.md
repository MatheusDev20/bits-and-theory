# Amazon EC2 – Cheat Sheet

---

## 📝 Basic Definition
- **Elastic Compute Cloud (EC2)** is the **core compute service** of AWS.
- Provides **virtual servers (instances)** in the cloud — similar components to a physical computer: CPU, RAM, storage, network interface.
- Runs various OSs: **Linux, Windows, macOS**.
- M1 MAC Instances can be runned
- Integrated with:
  - **VPC** for networking
  - **Security Groups / NACLs** for access control
  - **EBS/EFS/Instance Store** for storage
  - **IAM roles** for permissions
- Supports **Auto Scaling** to add/remove instances automatically.
- **Amazon Machine Image (AMI)** lets you:
  - Launch pre-configured instances.
  - Re-create servers in another **Availability Zone (AZ)** or Region.
  - Use custom AMIs for backups & disaster recovery.

---

## 💰 Purchase Options

AWS offers **flexible pricing models** to balance **cost, commitment, and availability**.

### 1. **On-Demand Instances**
- **Pay-as-you-go:** no long-term commitment.
- **Billing:**  
  - **Linux:** per **second** (after 60-sec minimum).  
  - **Windows/macOS:** per **hour**.
- **Use Cases:**
  - **Short-term, unpredictable workloads** that cannot be interrupted.
  - **Critical production workloads** requiring immediate capacity.
- **Capacity Reservation:** Optional add-on to guarantee compute capacity in a specific AZ.
- 💲 **Most expensive option** per unit time.

---

### 2. **Spot Instances**
- Uses **spare, unused EC2 capacity** at **up to 90% lower cost** than On-Demand.
- **Pricing:** fluctuates with **supply and demand**.
- ⚠️ **Can be interrupted** by AWS with 2-minute warning when capacity is reclaimed.
- **Use Cases:**
  - **Stateless, fault-tolerant workloads** that can restart/continue later.
  - **Batch jobs, Big Data analytics, CI/CD jobs, test/dev environments.**
  - **“Peak load overflow”** to supplement On-Demand fleets.
- **Tools:**
  - **Spot Fleet:** Manage a collection of Spot + On-Demand to meet a target capacity.
  - **Spot Blocks:** Reserve Spot capacity for a fixed duration (1–6 hours) **without interruption**.

---

### 3. **Reserved Instances (RI)**
- Commit to a **specific instance family, Region, and term**:
  - **1-year or 3-year** term.
  - Options: **All Upfront, Partial Upfront, No Upfront** (affects discount).
- **Discount:** Up to **72% cheaper** than On-Demand.
- **Instance Type Flexibility:**  
  - **Standard RI:** largest discount, least flexibility.  
  - **Convertible RI:** can change instance family, OS, tenancy during the term.
- **Use Cases:**
  - **Steady-state workloads** (databases, enterprise apps) with predictable usage.

---

### 4. **Savings Plans**
- Flexible **commitment to spend ($/hr)** on EC2 (or Fargate/Lambda) for **1- or 3-year terms**.
- **Compute Savings Plan:** applies across **any Region, instance family, OS, tenancy** → **most flexible**.
- **EC2 Instance Savings Plan:** similar to RIs, tied to **specific instance family/Region** → higher discount.
- **Use Cases:** predictable overall compute spend but need **instance/Region flexibility**.

---

### 5. **Dedicated Options**
- Provide **physical isolation** for compliance or licensing requirements.

| Option | Description | Use Case |
|--------|-------------|----------|
| **Dedicated Host** | **Physical server fully dedicated** to a single customer. You control host-level attributes and can use **bring-your-own licenses (BYOL)** for Windows/SQL. | Required for **per-socket / per-core licensing**, compliance, or audit. |
| **Dedicated Instance** | Runs on **dedicated hardware** but you don’t manage the host itself. | **Isolated tenancy** without needing full host control. |

---

### 6. **Capacity Reservation**
- Reserve EC2 capacity in a **specific AZ** **without a long-term contract**.
- Combine with **RIs or Savings Plans** for lower price.
- **Use Cases:** short-term needs to **guarantee capacity** for sudden traffic spikes or scheduled big events.

---

## 🟢 Quick Use-Case Mapping

| Need / Scenario | Best Option |
|-----------------|-------------|
| Short-term, unpredictable workload | **On-Demand** |
| Lowest price for interruptible tasks | **Spot Instance** |
| Steady-state, predictable workload | **Reserved Instance** |
| Need pricing discount but flexibility across Regions/services | **Savings Plan (Compute)** |
| Must meet compliance / BYOL licensing | **Dedicated Host** |
| Need guaranteed capacity for a specific time & AZ | **Capacity Reservation** |

---

## 🔑 Exam Tips
- **Spot** = cheapest but **interruptible**.
- **On-Demand** = **highest cost** but **no commitment**.
- **Reserved & Savings Plans** = **cheapest for long-term steady workloads**.
- **Dedicated Host vs Instance:** host = full physical server control, instance = just runs on isolated hardware.
- **Capacity Reservation** ≠ RI: res
