# AWS Well-Architected Framework – Cheat Sheet

---

## 📝 Definition
The **AWS Well-Architected Framework (WAF)** provides **best-practice guidelines** to help you **design, build, and operate** workloads in the AWS Cloud.

It helps architects:
- Understand the **trade-offs** of design decisions.
- Build systems that are **secure, reliable, cost-efficient, high-performing, and sustainable**.
- Continuously **improve and optimize** workloads over time.

## Design Principles

– Stop guessing your capacity needs.

– Test systems at production scale.

– Automate to make architectural experimentation easier.

– Allow for evolutionary architectures.

– Drive architectures using data.

– Improve through game days.

## 🏛️ The Seven Pillars

| Pillar | Focus | Key Practices |
|--------|-------|---------------|
| **Operational Excellence** | Run and monitor workloads to **deliver business value** and **continuously improve** processes. | Automation, CI/CD, runbooks/playbooks, post-incident analysis (blameless). |
| **Security** | Protect **data, systems, and assets** while delivering business value. | IAM least-privilege, data encryption (at-rest & in-transit), security events logging & monitoring. |
| **Reliability** | Ensure workloads **recover quickly** from failures and meet **availability** requirements. | Fault-tolerant design (multi-AZ, multi-Region), automatic scaling, backups & DR planning. |
| **Performance Efficiency** | Use **compute, storage, database, and network resources efficiently** to meet requirements as they evolve. | Right-sizing, serverless, caching, choosing the right storage/database solution. |
| **Cost Optimization** | Deliver business value at **lowest price point**. | Demand-based scaling, using **Spot/RIs/Savings Plans**, eliminate unused resources, monitor with **Cost Explorer/Budgets**. |
| **Sustainability** *(added in 2021)* | Minimize the **environmental impact** of workloads. | Choose energy-efficient Regions, use serverless & managed services, scale down idle resources. |
| **(NEW)** *–* Sometimes **Security & Compliance** considered separately in industry discussions, but the 6+1 above are official. |

---

### Cloud Architecture Best Practices

- Decouple your components
- Think in paralell
- Implement Elasticity
- Design for failure


## 🔑 Key Concepts
- A **Well-Architected Review** is a structured assessment of workloads against these pillars.
- The framework promotes **continuous improvement** — it’s not one-time.
- Often exam questions describe a scenario → choose the pillar that best addresses it.

---

## 🟢 Quick Exam Mapping

| Scenario Keyword | Relevant Pillar |
|------------------|-----------------|
| “Automating deployments, runbooks, operational insights” | **Operational Excellence** |
| “Encryption, IAM, least-privilege, compliance” | **Security** |
| “Multi-AZ failover, disaster recovery” | **Reliability** |
| “Right instance type, serverless, caching” | **Performance Efficiency** |
| “Lowering unused capacity costs” | **Cost Optimization** |
| “Reduce energy footprint, choose green Region” | **Sustainability** |

---

## ✍️ Tagline to Remember
> **“Build for change, secure by design, scale reliably, perform efficiently, pay less, and go green.”**
