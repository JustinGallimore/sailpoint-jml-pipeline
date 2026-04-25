# JML Pipeline — Visual Build Walkthrough
## SailPoint Identity Security Cloud (ISC)
### Authored by Justin Gallimore — IAM Engineer

---

> This document provides a complete visual walkthrough of the JML automation pipeline build. Each section includes a screenshot and explanation of what was configured, why it matters, and how it fits into the overall architecture.

---

## Phase 1 — HR Source Configuration

### Step 1 — Creating The HR Source

The first step was creating a new source in SailPoint ISC to represent the HR system. In enterprise environments this would be a live connector to Workday, SAP, or BambooHR. In this lab a CSV file hosted on an SFTP server simulates the HR data feed.

![HR Source Created](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/01_hr_source_csv_created.png)

---

### Step 2 — Confirming File Type

The source was configured as a Delimited File type — the correct connector for CSV-based HR sources in SailPoint ISC.

![File Type Confirmed](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/02_hr_source_csv_filetype_confirmed.png)

---

### Step 3 — Selecting Source Type

SailPoint presents multiple source type options. Delimited File was selected to match the CSV format of the HR data.

![Select Source Type](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/03_create_source_select_source_type.png)

---

### Step 4 — Connector Found

SailPoint successfully located and loaded the Delimited File connector — confirming the connector is available in this ISC tenant.

![Connector Found](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/04_delimited_file_connector_found.png)

---

### Step 5 — Source Configuration Blank

The source configuration screen opened with all fields blank — ready for SFTP connection details to be entered.

![Source Config Blank](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/05_delimited_file_source_config_blank.png)

---

### Step 6 — Source Configuration Filled

SFTP connection details entered — host IP, port 22, username, and password pointing to the Rebex SFTP server running on the local Windows machine.

![Source Config Filled](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/06_delimited_file_source_config_filled.png)

---

### Step 7 — VA Cluster Connected

The Virtual Appliance cluster confirmed as connected in SailPoint ISC — establishing the secure tunnel between the cloud tenant and the on-premises SFTP server.

![VA Cluster Connected](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/06b_VA_cluster_connected.png)

---

### Step 8 — Source Reopened From Saved

After saving the source configuration it was reopened to verify all settings persisted correctly before proceeding to schema configuration.

![Source Reopened](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/07_source_reopened_from_saved.png)

---

### Step 9 — Connection Settings

The connection settings panel showing the SFTP host, port, and authentication details configured for the HR CSV source.

![Connection Settings](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/08_connection_settings.png)

---

### Step 10 — SSHD Status Check

SSH daemon status verified on the SFTP server to confirm the service was running and accepting connections on port 22.

![SSHD Status Check](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/09_sshd_status_check.png)

---

### Step 11 — SSHD Start Attempt

SSHD service start command executed to ensure the SFTP server was fully operational before running the connection test.

![SSHD Start Attempt](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/10_sshd_start_attempt.png)

---

### Step 12 — Connection Settings SFTP Configured

Final SFTP connection settings confirmed — all fields populated and ready for connection test.

![Connection Settings SFTP](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/11_connection_settings_sftp_configured.png)

---

### Step 13 — Connection Test Result

SailPoint ISC connection test executed against the Rebex SFTP server — confirming successful connectivity between the cloud tenant and the on-premises file server.

![Connection Test Result](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/12_connection_test_result.png)

---

### Step 14 — Parsing Settings

CSV parsing settings configured — defining how SailPoint reads and interprets the HR data file including delimiter type and header row settings.

![Parsing Settings](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/13_parsing_settings.png)

---

### Step 15 — Parsing Settings Delimited Selected

Comma delimiter selected as the file parsing format — matching the structure of the hr_employees.csv file.

![Parsing Settings Delimited](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/14_parsing_settings_delimited_selected.png)

---

### Step 16 — File Settings

File-level settings configured including file path on the SFTP server where SailPoint will look for the HR CSV during each aggregation run.

![File Settings](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/15_file_settings.png)

---

### Step 17 — Account File Settings

Account-level file settings configured — defining which columns in the CSV map to account attributes in SailPoint.

![Account File Settings](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/16_account_file_settings.png)

---

### Step 18 — CSV Uploaded

The HR CSV file successfully uploaded to the SFTP server — confirming the file is accessible at the configured path.

![CSV Uploaded](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/17_drivehq_csv_uploaded.png)

---

### Step 19 — Connection Settings Configured

Final connection settings review confirming all SFTP parameters are correctly configured and pointing to the right file location.

![Connection Settings Configured](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/18_connection_settings_drivehq_configured.png)

---

### Step 20 — Connection Test Result Confirmed

Second connection test executed after file upload — confirming SailPoint can locate and access the CSV file on the SFTP server.

![Connection Test Confirmed](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/19_drivehq_connection_test_result.png)

---

## Phase 2 — Account Schema Configuration

### Step 21 — File Path Configured

The file path to the HR CSV on the SFTP server confirmed and locked in — this is the exact location SailPoint will pull from during every aggregation.

![File Path Configured](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/20_file_path_configured.png)

---

### Step 22 — Parsing Configuration

CSV parsing rules finalized — SailPoint now knows how to read and split the HR data file into individual identity records.

![Parsing Configuration](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/21_parsing_configuration.png)

---

### Step 23 — Account Schema

The account schema screen in SailPoint ISC — this is where each CSV column is mapped to a corresponding SailPoint account attribute.

![Account Schema](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/22_account_schema.png)

---

### Step 24 — Account Schema Edit Mode

Schema opened in edit mode to add and configure all required attributes from the HR CSV file.

![Schema Edit Mode](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/23_account_schema_edit_mode.png)

---

### Step 25 — Schema Updated

All CSV columns added to the schema — id, givenName, familyName, e-mail, department, title, employeeType, startDate, status — each mapped to the correct data type.

![Schema Updated](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/24_schema_updated.png)

---

### Step 26 — Account Schema Complete

Final schema review confirming all attributes are correctly defined and the anchor attribute is properly set for identity correlation.

![Schema Complete](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/25_account_schema_complete.png)

---

### Step 27 — Account Schema Full View

Full schema view showing all configured attributes — confirming the complete column mapping between the HR CSV and SailPoint.

![Schema Full View](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/26_account_schema_full_view.png)

---

### Step 28 — Account Correlation

Account correlation configuration — defining how SailPoint matches CSV records to existing identities to prevent duplicate identity creation on re-aggregation.

![Account Correlation](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/27_account_correlation.png)

---

### Step 29 — Add Criteria Clicked

Correlation criteria configuration screen opened — ready to define the matching rule between the CSV employee ID and the SailPoint identity attribute.

![Add Criteria](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/27_add_criteria_clicked.png)

---

### Step 30 — Account Correlation Configured

Correlation rule set — employeeId from the CSV matched to the corresponding SailPoint identity attribute ensuring accurate identity linking on every aggregation run.

![Correlation Configured](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/27_account_correlation_configured.png)

---

### Step 31 — Correlation Saved Success

Correlation rule saved successfully — SailPoint will now correctly match incoming CSV records to existing identities on every subsequent aggregation.

![Correlation Saved](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/28_correlation_saved_success.png)

---

## Phase 3 — Identity Profile Configuration

### Step 32 — Identity Profile Screen

The Identity Profile screen in SailPoint ISC — this is where the rules are defined for how raw account data gets transformed into a full identity record.

![Identity Profile Screen](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/29_identity_profile_screen.png)

---

### Step 33 — Identity Profiles Page

The Identity Profiles list page showing the HR_CSV_Lab_Identity_Profile created for this project.

![Identity Profiles Page](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/30_identity_profiles_page.png)

---

### Step 34 — Create Identity Profile

New identity profile creation screen — naming the profile and linking it to the HR CSV source.

![Create Identity Profile](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/31_create_identity_profile.png)

---

### Step 35 — Mappings Username

Identity attribute mappings configured — the username attribute mapped to the employeeId from the CSV.

![Mappings Username](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/34_mappings_username.png)

---

### Step 36 — Mappings Email Name Configured

Email and display name mappings configured — pulling givenName, familyName, and e-mail from the CSV.

![Mappings Email](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/35_mappings_email_name_configured.png)

---

### Step 37 — Department And Employee ID

Department and Employee ID attribute mappings confirmed.

![Department And Employee ID](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/36_department_and_employee_ID.png)

---

### Step 38 — Start Date

Start Date attribute mapping configured.

![Start Date](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/37_start_date.png)

---

### Step 39 — Title

Job title attribute mapping configured.

![Title](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/38_Title.png)

---

### Step 40 — Identity Profile Status

Identity profile status confirmed as active — the profile is live and governing all identity lifecycle events.

![Identity Profile Status](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/39_identity_profile_status.png)

---

### Step 41 — HR Source CSV Updated Family Name

Family name attribute mapping updated — correcting the column reference to ensure lastName populates correctly.

![CSV Updated Family Name](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/40_hr_source_csv_updated_familyName.png)

---

## Phase 4 — Aggregation

### Step 42 — Aggregation Started

First aggregation run initiated — SailPoint connecting to the Rebex SFTP server to retrieve the HR CSV file.

![Aggregation Started](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/41_aggregation_started.png)

---

### Step 43 — Aggregation Results

Initial aggregation results — confirming SailPoint successfully read and processed the HR CSV file.

![Aggregation Results](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/42_aggregation_results.png)

---

### Step 44 — Three Accounts Created

Three identity records created — James Carter, Maria Santos, and Derek Williams successfully ingested from the HR CSV.

![Three Accounts Created](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/43_three_accounts_created.png)

---

### Step 45 — Rebex Connection Settings

Rebex Tiny SFTP Server configuration panel — showing the server running at 192.168.50.91 port 22.

![Rebex Connection Settings](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/44_rebex_connection_settings.png)

---

### Step 46 — Aggregation V2 Success

Second aggregation completed successfully — all three identities now showing complete attribute data.

![Aggregation V2 Success](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/45_aggregationV2_success.png)

---

### Step 47 — Aggregation Success

Final confirmation — Objects Scanned: 3, Status: Success. The HR source pipeline is fully operational.

![Aggregation Success](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/45_aggregation_success.png)

---

## Phase 5 — Identity Verification

### Step 48 — James Carter Identity Cube

James Carter's identity cube — all attributes successfully populated from the HR CSV source.

![James Carter Identity Cube](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/46_james_carter_identity_cube.png)

---

### Step 49 — James Carter Identity Found

James Carter confirmed as a Human Identity in SailPoint ISC.

![James Carter Found](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/46_james_carter_identity_found.png)

---

### Step 50 — James Carter Complete

James Carter identity fully verified — all required attributes present, ready for lifecycle event processing.

![James Carter Complete](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/48_james_carter_complete.png)

---

### Step 51 — Maria Santos Complete

Maria Santos identity cube verified — all attributes populated correctly.

![Maria Santos Complete](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/49_maria_santos_complete.png)

---

### Step 52 — Derek Williams Complete

Derek Williams identity cube verified — all three original identities confirmed complete and ready for lifecycle automation.

![Derek Williams Complete](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/50_derek_williams_complete.png)

---

## Phase 6 — Lifecycle Management

### Step 53 — Lifecycle Management

The Lifecycle Management screen inside the HR_CSV_Lab_Identity_Profile — showing all available lifecycle states.

![Lifecycle Management](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/51_lifecycle_management.png)

---

### Step 54 — Active Lifecycle Enabled

The Active lifecycle state enabled — Apply Changes executed successfully.

![Active Lifecycle Enabled](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/52_active_lifecycle_enabled.png)

---

## Phase 7 — Joiner Workflow

### Step 55 — Joiner Workflow Canvas

The completed Joiner workflow canvas — Trigger (Identity Created) → Action (Send Email) → Operator (End Step Success). Built from scratch with zero validation errors.

![Joiner Workflow Canvas](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/53_joiner_workflow_canvas.png)

---

### Step 56 — Workflow Test Setup

Joiner workflow test setup screen — showing the complete workflow chain and JSON test input panel.

![Workflow Test Setup](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/54_workflow_test_setup.png)

---

### Step 57 — Workflow Enabled

Joiner workflow status changed to Enabled — the automation is now live and listening for new identity creation events.

![Workflow Enabled](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/55_workflow_enabled.png)

---

### Step 58 — Aggregation 4 Objects Scanned

Fourth employee added and aggregation run — Objects Scanned: 4, Status: Success. Joiner workflow fired automatically.

![4 Objects Scanned](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/56_aggregation_4_objects_scanned.png)

---

### Step 59 — Joiner Workflow Execution

Joiner workflow execution log showing Status: Complete — workflow fired automatically on new identity creation.

![Joiner Execution](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/57_joiner_workflow_execution.png)

---

### Step 60 — Joiner Email Proof

Email notification received from no-reply@sailpoint.com — Joiner workflow fired successfully end to end.

![Joiner Email Proof](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/58b_joiner_email_proof.png)

---

### Step 61 — Joiner Email Clean

Clean Joiner email showing real employee data — Name, Employee ID, Department, Title, and Start Date all correctly populated.

![Joiner Email Clean](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/66_joiner_email_proof_clean.png)

---

## Phase 8 — Leaver Workflow

### Step 62 — Terminated Lifecycle Enabled

The Terminated lifecycle state enabled — Remove All Access confirmed on, ensuring automatic access revocation on offboarding.

![Terminated Lifecycle](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/58_terminated_lifecycle_enabled.png)

---

### Step 63 — Leaver Workflow Canvas

The completed Leaver workflow canvas — Trigger (Identity Lifecycle State Changed) → Action (Send Email) → Operator (End Step Success).

![Leaver Workflow Canvas](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/59_leaver_workflow_canvas.png)

---

### Step 64 — Leaver Workflow Enabled

Leaver workflow Enabled — offboarding automation live and listening for terminated lifecycle state change events.

![Leaver Workflow Enabled](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/60_leaver_workflow_enabled.png)

---

### Step 65 — Leaver Aggregation Success

Aggregation run after Sarah Mitchell's status changed to terminated — SailPoint detected the lifecycle state change.

![Leaver Aggregation](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/62_leaver_aggregation_success.png)

---

### Step 66 — Sarah Mitchell Terminated

Sarah Mitchell's identity cube showing Lifecycle State: terminated — SailPoint automatically moved her identity to the Terminated state.

![Sarah Mitchell Terminated](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/63_sarah_mitchell_terminated.png)

---

### Step 67 — Leaver Workflow Execution

Leaver workflow execution log showing Status: Complete — workflow fired automatically on terminated lifecycle state change.

![Leaver Execution](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/64_leaver_workflow_execution.png)

---

### Step 68 — Leaver Email Proof

Clean Leaver email notification confirming offboarding automation working end to end.

![Leaver Email Clean](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/65b_leaver_email_proof_clean.png)

---

## Phase 9 — Mover Workflow

### Step 69 — Mover Workflow Canvas

The completed Mover workflow canvas — Trigger (Identity Attributes Changed) → Action (Send Email) → Operator (End Step Success). Completes the full JML pipeline.

![Mover Workflow Canvas](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/67_mover_workflow_canvas.png)

---

### Step 70 — Mover Workflow Enabled

Mover workflow Enabled — department transfer automation live and listening for attribute change events.

![Mover Workflow Enabled](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/68_mover_workflow_enabled.png)

---

### Step 71 — Mover Aggregation Success

Aggregation run after James Carter's department changed from Engineering to IT — SailPoint detected the attribute change.

![Mover Aggregation](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/69_mover_aggregation_success.png)

---

### Step 72 — Mover Workflow Execution

Mover workflow execution log showing Status: Complete — workflow fired automatically on department attribute change.

![Mover Execution](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/70_mover_workflow_execution.png)

---

### Step 73 — Mover Email Proof

Email notification confirming James Carter's department transfer — full JML pipeline proven end to end.

![Mover Email Proof](https://raw.githubusercontent.com/JustinGallimore/sailpoint-jml-pipeline/main/Screenshots/71_mover_email_proof.png)

---

## Pipeline Complete

| Event | Identity | Trigger | Status |
|---|---|---|---|
| Joiner | Marcus Thompson | Identity Created | Complete |
| Mover | James Carter | Identity Attributes Changed | Complete |
| Leaver | Sarah Mitchell | Identity Lifecycle State Changed | Complete |

---

*Visual walkthrough authored by Justin Gallimore — IAM Engineer*
*SailPoint ISC JML Automation Pipeline — April 2026*