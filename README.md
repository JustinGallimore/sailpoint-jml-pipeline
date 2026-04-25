# SailPoint ISC — JML Automation Pipeline
### Identity & Access Management | Enterprise Lab Project

---

## 📌 Project Overview

This project demonstrates a fully functional **Joiner-Mover-Leaver (JML) automation pipeline** built in **SailPoint Identity Security Cloud (ISC)**. The pipeline automates identity lifecycle management by integrating a simulated HR data source with SailPoint's workflow engine — triggering automated onboarding, transfer, and offboarding processes in real time.

This lab replicates the core IAM operations found in enterprise environments, including HR source ingestion via SFTP, identity aggregation, lifecycle state management, and event-driven workflow automation.

---

## 🏗️ Architecture Overview
HR System (CSV)
│
▼
SFTP Server (Rebex — 192.168.50.91)
│
▼
SailPoint ISC — HR_Source_CSV_Lab
│
▼
Identity Aggregation Engine
│
├──► Joiner Event ──► Joiner Workflow ──► Email Notification
│
├──► Mover Event  ──► Mover Workflow  ──► Email Notification
│
└──► Leaver Event ──► Leaver Workflow ──► Access Revocation + Email Notification
---

## 🛠️ Tech Stack

| Component | Tool / Platform |
|---|---|
| Identity Governance Platform | SailPoint Identity Security Cloud (ISC) |
| HR Source Simulation | CSV flat file |
| File Transfer Protocol | SFTP via Rebex Tiny SFTP Server |
| Workflow Automation | SailPoint Workflow Builder |
| Identity Lifecycle Management | SailPoint Lifecycle States |
| Notification System | SailPoint Send Email Action |
| Virtual Infrastructure | VirtualBox (VA Cluster) |
| Operating System | Windows (SFTP Host) |

---

## 👥 Identity Dataset

| Employee ID | Name | Department | Title | Status |
|---|---|---|---|---|
| JG9001 | James Carter | Engineering → IT | Software Engineer → Systems Engineer | Active (Mover) |
| JG9002 | Maria Santos | Finance | Financial Analyst | Active |
| JG9003 | Derek Williams | IT | Systems Administrator | Active |
| JG9004 | Sarah Mitchell | Marketing | Marketing Manager | Terminated (Leaver) |
| JG9005 | Marcus Thompson | HR | HR Specialist | Active (Joiner) |

---

## ⚙️ What Was Built

### 1️⃣ HR Source Configuration
- Created a CSV-based HR source (`HR_Source_CSV_Lab`) in SailPoint ISC
- Configured SFTP connector pointing to Rebex server at `192.168.50.91:22`
- Defined account schema with attributes: `id`, `givenName`, `familyName`, `e-mail`, `department`, `title`, `employeeType`, `startDate`, `status`
- Configured account correlation rules mapping `employeeId` to SailPoint identity
- Built identity profile (`HR_CSV_Lab_Identity_Profile`) with full attribute mappings
- Validated aggregation pipeline — Objects Scanned: 5, Status: Success

**Screenshots:** `01` through `45`

---

### 2️⃣ Joiner Automation
**Trigger:** New identity detected during aggregation (`Identity Created`)

**Workflow:** `Joiner-WF-Justin Gallimore`

**What happens:**
- New employee row added to HR CSV
- CSV uploaded to SFTP server
- SailPoint aggregation detects new identity
- Joiner workflow fires automatically
- Email notification delivered confirming new hire onboarding

**Test Result:** Marcus Thompson (JG9005) successfully onboarded — workflow executed, email delivered ✅

**Screenshots:** `51`, `52`, `53`, `54`, `55`, `56`, `57`, `58b`, `66`

---

### 3️⃣ Mover Automation
**Trigger:** Existing identity attribute change detected (`Identity Attributes Changed`)

**Workflow:** `Mover-WF-Justin Gallimore`

**What happens:**
- Existing employee department/title updated in HR CSV
- CSV uploaded to SFTP server
- SailPoint aggregation detects attribute delta
- Mover workflow fires automatically
- Email notification delivered confirming department transfer

**Test Result:** James Carter (JG9001) transferred from Engineering → IT — workflow executed, email delivered ✅

**Screenshots:** `67`, `68`, `69`, `70`, `71`

---

### 4️⃣ Leaver Automation
**Trigger:** Identity lifecycle state changed to Terminated (`Identity Lifecycle State Changed`)

**Workflow:** `Leaver-WF-Justin Gallimore`

**What happens:**
- Employee status set to `terminated` in HR CSV
- CSV uploaded to SFTP server
- SailPoint aggregation detects status change
- Lifecycle state mapping moves identity to Terminated state
- All access automatically removed (`Remove All Access` enabled)
- Leaver workflow fires automatically
- Email notification delivered confirming offboarding

**Test Result:** Sarah Mitchell (JG9004) successfully offboarded — lifecycle state set to Terminated, workflow executed, email delivered ✅

**Screenshots:** `58`, `59`, `60`, `61`, `62`, `63`, `64`, `65`, `65b`

---

## 📁 Repository Structure
├── CSV/
│   └── hr_employees.csv
├── Docs/
│   └── pipeline_architecture.md
├── Screenshots/
│   ├── 01_hr_source_csv_created.png
│   └── 71_mover_email_proof.png
├── Scripts/
├── SFTP Server/
│   └── rebex_configuration_notes.md
└── README.md
---

## 🔑 Key Configurations

### Identity Profile
- **Name:** `HR_CSV_Lab_Identity_Profile`
- **Source:** `HR_Source_CSV_Lab`
- **Lifecycle State Mapping:** `status` attribute → SailPoint lifecycle state
  - `active` → Active
  - `terminated` → Terminated

### Lifecycle States Configured
| State | Enable Lifecycle | Remove All Access | Account Action |
|---|---|---|---|
| Active | ✅ Enabled | ❌ Off | Enable — All Sources |
| Terminated | ✅ Enabled | ✅ On | Disable — All Sources |

### Workflows Built
| Workflow | Trigger | Status |
|---|---|---|
| `Joiner-WF-Justin Gallimore` | Identity Created | ✅ Enabled |
| `Mover-WF-Justin Gallimore` | Identity Attributes Changed | ✅ Enabled |
| `Leaver-WF-Justin Gallimore` | Identity Lifecycle State Changed | ✅ Enabled |

---

## 📊 Test Results Summary

| Event | Identity | Result | Execution Status |
|---|---|---|---|
| Joiner | Marcus Thompson (JG9005) | ✅ Identity Created, Email Delivered | Complete |
| Mover | James Carter (JG9001) | ✅ Attributes Updated, Email Delivered | Complete |
| Leaver | Sarah Mitchell (JG9004) | ✅ Terminated, Access Removed, Email Delivered | Complete |

---

## 💡 Key Takeaways

- **HR-driven identity lifecycle** — all identity events sourced from a single CSV file simulating a real HR system (Workday, SAP, etc.)
- **Event-driven automation** — zero manual intervention required once the pipeline is configured
- **Lifecycle state management** — proper mapping between HR status values and SailPoint lifecycle states is critical for accurate automation
- **Shared tenant considerations** — workflow naming conventions and trigger filters prevent unintended cross-tenant executions
- **Production parallels** — this pipeline mirrors real enterprise JML implementations

---

## 🔜 Phase 2 — Planned Enhancements

- [ ] Active Directory provisioning action on Joiner
- [ ] Role-based access assignment on Joiner
- [ ] Access profile revocation on Leaver
- [ ] Manager notification on Mover
- [ ] Approval workflow integration
- [ ] Scheduled aggregation via SailPoint scheduler

---

## 👤 Author

**Justin Gallimore**
IAM Engineer | SailPoint ISC | Microsoft Entra ID | Okta | CyberArk

---

*Built as part of an ongoing IAM portfolio lab series focused on real-world identity lifecycle automation.*
