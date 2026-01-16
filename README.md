# 🛡️ AWS Disaster Recovery: Automated DNS Failover & Data Protection

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Route53](https://img.shields.io/badge/Route53-Blue?style=for-the-badge&logo=amazon-route53&logoColor=white)](https://aws.amazon.com/route53/)
[![Backup](https://img.shields.io/badge/AWS_Backup-Red?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/backup/)

## 📌 Executive Summary
In an era of "always-on" services, infrastructure failure is a business risk. This project demonstrates a robust **Active-Passive Disaster Recovery (DR)** architecture on AWS. By leveraging **Route 53 Health Checks** and **AWS Backup**, I engineered a system that automatically detects server outages and reroutes traffic to a standby environment in a different Availability Zone, ensuring minimal downtime and zero data loss.



---

## 🏗️ Architecture Design
The solution is built across two distinct failure domains (Availability Zones) to protect against data center outages.

* **Primary Stack (AZ-1):** The active environment serving 100% of user traffic.
* **Secondary Stack (AZ-2):** A "Warm Standby" environment ready to scale and take over traffic.
* **Traffic Management:** Amazon Route 53 with **Failover Routing Policy**.
* **Monitoring:** Custom Route 53 Health Checks monitoring application heartbeats via HTTP/80.
* **Data Protection:** AWS Backup Vault with automated daily snapshot policies and lifecycle management.

---

## 🛠️ Tech Stack & Skills
* **Cloud:** Amazon Web Services (EC2, Route 53, AWS Backup, IAM)
* **Automation:** Bash Scripting (User Data)
* **Networking:** DNS Failover, Health Checks, TTL Optimization
* **Compliance:** RPO/RTO Strategic Planning

---

## 🚀 Implementation Details

### Phase 1: High Availability Setup
Deployed two Linux instances with custom `User Data` scripts. These scripts automate the installation of Apache and create environment-specific landing pages for visual verification during failover tests.

### Phase 2: Automated Data Protection
Configured an **AWS Backup Plan** targeting the Primary Stack.
* **RPO (Recovery Point Objective):** 24 Hours.
* **Lifecycle:** Snapshots are moved to cold storage after 30 days to optimize costs.
* **Verification:** Performed a point-in-time restore to validate data integrity.

### Phase 3: Intelligent DNS Failover
Established **Route 53 Health Checks** with a failure threshold of 3. 
* **Failover Logic:** Traffic points to Primary by default. If the health check fails 3 consecutive times, Route 53 updates the DNS record to point to the Secondary IP.
* **TTL Management:** Set to 60 seconds to ensure rapid propagation of DNS changes.

---

## 🧪 Testing the "Disaster"
To validate the architecture, I simulated a "Region-wide" failure by stopping the Primary EC2 instance:
1.  **Detection:** Route 53 Health Check turned "Unhealthy" within 90 seconds.
2.  **Failover:** Traffic was automatically routed to the Secondary server.
3.  **Verification:** Browser refresh showed the "Secondary DR Server" message, confirming a successful cutover.
4.  **Failback:** Restarting the Primary server triggered an automatic "Switch-back" once the health check returned to a healthy state.

---

## 📈 Key Results
| Metric | Achievement |
| :--- | :--- |
| **RTO (Recovery Time Objective)** | < 2 Minutes (Automated) |
| **RPO (Recovery Point Objective)** | 24 Hours (Daily Backups) |
| **Human Intervention** | 0% (Fully Automated Failover) |

---

## 📂 Project Structure
```text
.
├── scripts/
│   ├── primary-setup.sh      # Provisions the active web server
│   └── secondary-setup.sh    # Provisions the standby web server
├── diagrams/
│   └── architecture.png      # Visual flow of failover logic
└── README.md                 # Detailed project documentation
