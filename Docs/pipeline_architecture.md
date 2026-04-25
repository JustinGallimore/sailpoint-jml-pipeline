\# JML Pipeline — Technical Architecture Document

\## SailPoint Identity Security Cloud (ISC)



\---



\## 1. Overview



This document provides a detailed technical breakdown of the Joiner-Mover-Leaver (JML) automation pipeline built in SailPoint ISC. It is intended to serve as a reference for the architectural decisions, configuration details, and integration points used throughout the project.



\---



\## 2. Infrastructure Components



\### 2.1 Virtual Appliance (VA)

\- Deployed via VirtualBox on local Windows host

\- Serves as the secure communication bridge between SailPoint ISC and on-premises resources

\- Connected status confirmed in ISC during every lab session

\- VA Cluster display occasionally shows stale status — confirmed cosmetic, not functional



\### 2.2 SFTP Server

\- Tool: Rebex Tiny SFTP Server

\- Host: 192.168.50.91

\- Port: 22

\- Credentials: sailpoint / Sailpoint1

\- Purpose: Simulates enterprise HR file drop location

\- SailPoint ISC pulls CSV file from this server during every aggregation cycle



\### 2.3 HR Source File

\- Format: CSV (Comma Separated Values)

\- Filename: hr\_employees.csv

\- Location: Rebex SFTP server root folder

\- Columns: id, givenName, familyName, e-mail, department, title, employeeType, startDate, status



\---



\## 3. SailPoint ISC Configuration



\### 3.1 Source Configuration

\- \*\*Source Name:\*\* HR\_Source\_CSV\_Lab

\- \*\*Connector Type:\*\* Delimited File (CSV)

\- \*\*File Type:\*\* CSV

\- \*\*SFTP Host:\*\* 192.168.50.91:22

\- \*\*Authentication:\*\* Username/Password



\### 3.2 Account Schema

| Schema Attribute | CSV Column | Data Type |

|---|---|---|

| id | id | String (Anchor) |

| givenName | givenName | String |

| familyName | familyName | String |

| e-mail | e-mail | String |

| department | department | String |

| title | title | String |

| employeeType | employeeType | String |

| startDate | startDate | String |

| status | status | String |



\### 3.3 Account Correlation

\- \*\*Correlation Rule:\*\* employeeId matched to SailPoint identity attribute

\- \*\*Result:\*\* Prevents duplicate identities on re-aggregation



\### 3.4 Identity Profile

\- \*\*Name:\*\* HR\_CSV\_Lab\_Identity\_Profile

\- \*\*Source:\*\* HR\_Source\_CSV\_Lab

\- \*\*Lifecycle State Mapping:\*\*

&#x20; - status = `active` → Active lifecycle state

&#x20; - status = `terminated` → Terminated lifecycle state



\---



\## 4. Lifecycle State Configuration



\### 4.1 Active State

\- Enable Lifecycle: ✅ On

\- Remove All Access: ❌ Off

\- Enable Accounts: All Sources

\- Disable Accounts: No Sources

\- Purpose: Governs behavior when a new joiner identity is created



\### 4.2 Terminated State

\- Enable Lifecycle: ✅ On

\- Remove All Access: ✅ On

\- Enable Accounts: No Sources

\- Disable Accounts: All Sources

\- Purpose: Governs behavior when an employee is offboarded



\---



\## 5. Workflow Architecture



\### 5.1 Joiner Workflow

\- \*\*Name:\*\* Joiner-WF-Justin Gallimore

\- \*\*Trigger:\*\* Identity Created

\- \*\*Filter:\*\* None (fires on all new identity creation events)

\- \*\*Actions:\*\*

&#x20; 1. Send Email — notifies administrator of new joiner

&#x20; 2. End Step - Success

\- \*\*Test Result:\*\* Fired successfully on Marcus Thompson (JG9005) creation

\- \*\*Execution Status:\*\* Complete ✅



\### 5.2 Mover Workflow

\- \*\*Name:\*\* Mover-WF-Justin Gallimore

\- \*\*Trigger:\*\* Identity Attributes Changed

\- \*\*Filter:\*\* Attribute = department

\- \*\*Actions:\*\*

&#x20; 1. Send Email — notifies administrator of department transfer

&#x20; 2. End Step - Success

\- \*\*Test Result:\*\* Fired successfully on James Carter (JG9001) department change

\- \*\*Execution Status:\*\* Complete ✅



\### 5.3 Leaver Workflow

\- \*\*Name:\*\* Leaver-WF-Justin Gallimore

\- \*\*Trigger:\*\* Identity Lifecycle State Changed

\- \*\*Filter:\*\* None (fires on all lifecycle state change events)

\- \*\*Actions:\*\*

&#x20; 1. Send Email — notifies administrator of termination

&#x20; 2. End Step - Success

\- \*\*Test Result:\*\* Fired successfully on Sarah Mitchell (JG9004) termination

\- \*\*Execution Status:\*\* Complete ✅



\---



\## 6. Aggregation Pipeline



\### 6.1 Process Flow

1\. HR team updates CSV file with employee changes

2\. CSV file uploaded to Rebex SFTP server

3\. SailPoint ISC aggregation job initiated manually (production: scheduled)

4\. VA retrieves CSV file from SFTP server

5\. SailPoint parses CSV and compares against existing identities

6\. New identities → Joiner event triggered

7\. Changed attributes → Mover event triggered

8\. Status = terminated → Leaver event triggered

9\. Workflows fire automatically based on event type

10\. Email notifications delivered to administrator



\### 6.2 Aggregation Results

| Run | Objects Scanned | Status | Event Triggered |

|---|---|---|---|

| Initial | 3 | Success | None |

| Joiner Test | 4 | Success | Joiner — Sarah Mitchell |

| Joiner Test 2 | 5 | Success | Joiner — Marcus Thompson |

| Leaver Test | 5 | Success | Leaver — Sarah Mitchell |

| Mover Test | 5 | Success | Mover — James Carter |



\---



\## 7. Identity Dataset



| Employee ID | Name | Department | Title | Start Date | Status |

|---|---|---|---|---|---|

| JG9001 | James Carter | IT | Systems Engineer | 2025-01-15 | Active |

| JG9002 | Maria Santos | Finance | Financial Analyst | 2025-02-01 | Active |

| JG9003 | Derek Williams | IT | Systems Administrator | 2025-03-10 | Active |

| JG9004 | Sarah Mitchell | Marketing | Marketing Manager | 2026-04-25 | Terminated |

| JG9005 | Marcus Thompson | HR | HR Specialist | 2026-04-25 | Active |



\---



\## 8. Key Technical Decisions



\- \*\*CSV over API\*\* — chosen to simulate HR source without requiring a live HR system license

\- \*\*Rebex SFTP\*\* — lightweight, free tool that accurately simulates enterprise SFTP file drop

\- \*\*Hardcoded email body\*\* — used in lab due to shared tenant email template variable limitations; production implementation would use dynamic `$identity` variables

\- \*\*Manual aggregation\*\* — used for lab control; production environments use scheduled aggregation triggers

\- \*\*Shared tenant awareness\*\* — workflow names prefixed with engineer name to prevent collision with other tenant users



\---



\## 9. Production Considerations



In a production enterprise environment this pipeline would be enhanced with:



\- Live HR system connector (Workday, SAP SuccessFactors, BambooHR)

\- Scheduled aggregation (hourly or real-time event-based)

\- Active Directory provisioning on Joiner

\- Role-based access assignment via Access Profiles

\- Manager approval workflows on sensitive access

\- Full access revocation on Leaver via entitlement removal

\- Audit logging and compliance reporting



\---



\*Document authored by Justin Gallimore — IAM Engineer\*

\*Project: SailPoint ISC JML Automation Pipeline\*

\*Date: April 2026\*

