\# JML Pipeline — Visual Build Walkthrough

\## SailPoint Identity Security Cloud (ISC)

\### authored by Justin Gallimore — IAM Engineer



\---



> This document provides a complete visual walkthrough of the JML automation pipeline build. Each section includes a screenshot and explanation of what was configured, why it matters, and how it fits into the overall architecture.



\---



\## Phase 1 — HR Source Configuration



\### Step 1 — Creating The HR Source



The first step was creating a new source in SailPoint ISC to represent the HR system. In enterprise environments this would be a live connector to Workday, SAP, or BambooHR. In this lab a CSV file hosted on an SFTP server simulates the HR data feed.



!\[HR Source Created](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/01\_hr\_source\_csv\_created.png)



\---



\### Step 2 — Confirming File Type



The source was configured as a Delimited File type — the correct connector for CSV-based HR sources in SailPoint ISC.



!\[File Type Confirmed](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/02\_hr\_source\_csv\_filetype\_confirmed.png)



\---



\### Step 3 — Selecting Source Type



SailPoint presents multiple source type options. Delimited File was selected to match the CSV format of the HR data.



!\[Select Source Type](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/03\_create\_source\_select\_source\_type.png)



\---



\### Step 4 — Connector Found



SailPoint successfully located and loaded the Delimited File connector — confirming the connector is available in this ISC tenant.



!\[Connector Found](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/04\_delimited\_file\_connector\_found.png)



\---



\### Step 5 — Source Configuration Blank



The source configuration screen opened with all fields blank — ready for SFTP connection details to be entered.



!\[Source Config Blank](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/05\_delimited\_file\_source\_config\_blank.png)



\---



\### Step 6 — Source Configuration Filled



SFTP connection details entered — host IP, port 22, username, and password pointing to the Rebex SFTP server running on the local Windows machine.



!\[Source Config Filled](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/06\_delimited\_file\_source\_config\_filled.png)



\---



\### Step 7 — VA Cluster Connected



The Virtual Appliance (VA) cluster confirmed as connected in SailPoint ISC — establishing the secure tunnel between the cloud tenant and the on-premises SFTP server.



!\[VA Cluster Connected](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/06b\_VA\_cluster\_connected.png)



\---



\### Step 8 — Source Reopened From Saved



After saving the source configuration it was reopened to verify all settings persisted correctly before proceeding to schema configuration.



!\[Source Reopened](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/07\_source\_reopened\_from\_saved.png)



\---



\### Step 9 — Connection Settings



The connection settings panel showing the SFTP host, port, and authentication details configured for the HR CSV source.



!\[Connection Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/08\_connection\_settings.png)



\---



\### Step 10 — SSHD Status Check



SSH daemon status verified on the SFTP server to confirm the service was running and accepting connections on port 22.



!\[SSHD Status Check](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/09\_sshd\_status\_check.png)



\---



\### Step 11 — SSHD Start Attempt



SSHD service start command executed to ensure the SFTP server was fully operational before running the connection test.



!\[SSHD Start Attempt](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/10\_sshd\_start\_attempt.png)



\---



\### Step 12 — Connection Settings SFTP Configured



Final SFTP connection settings confirmed — all fields populated and ready for connection test.



!\[Connection Settings SFTP](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/11\_connection\_settings\_sftp\_configured.png)



\---



\### Step 13 — Connection Test Result



SailPoint ISC connection test executed against the Rebex SFTP server — confirming successful connectivity between the cloud tenant and the on-premises file server.



!\[Connection Test Result](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/12\_connection\_test\_result.png)



\---



\### Step 14 — Parsing Settings



CSV parsing settings configured — defining how SailPoint reads and interprets the HR data file including delimiter type and header row settings.



!\[Parsing Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/13\_parsing\_settings.png)



\---



\### Step 15 — Parsing Settings Delimited Selected



Comma delimiter selected as the file parsing format — matching the structure of the hr\_employees.csv file.



!\[Parsing Settings Delimited](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/14\_parsing\_settings\_delimited\_selected.png)



\---



\### Step 16 — File Settings



File-level settings configured including file path on the SFTP server where SailPoint will look for the HR CSV during each aggregation run.



!\[File Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/15\_file\_settings.png)



\---



\### Step 17 — Account File Settings



Account-level file settings configured — defining which columns in the CSV map to account attributes in SailPoint.



!\[Account File Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/16\_account\_file\_settings.png)



\---



\### Step 18 — DriveHQ CSV Uploaded



The HR CSV file successfully uploaded to the SFTP server — confirming the file is accessible at the configured path.



!\[CSV Uploaded](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/17\_drivehq\_csv\_uploaded.png)



\---



\### Step 19 — Connection Settings DriveHQ Configured



Final connection settings review confirming all SFTP parameters are correctly configured and pointing to the right file location.



!\[DriveHQ Connection Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/18\_connection\_settings\_drivehq\_configured.png)



\---



\### Step 20 — DriveHQ Connection Test Result



Second connection test executed after file upload — confirming SailPoint can locate and access the CSV file on the SFTP server.



!\[DriveHQ Connection Test](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/19\_drivehq\_connection\_test\_result.png)



\---



\## Phase 2 — Account Schema Configuration



\### Step 21 — File Path Configured



The file path to the HR CSV on the SFTP server confirmed and locked in — this is the exact location SailPoint will pull from during every aggregation.



!\[File Path Configured](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/20\_file\_path\_configured.png)



\---



\### Step 22 — Parsing Configuration



CSV parsing rules finalized — SailPoint now knows how to read and split the HR data file into individual identity records.



!\[Parsing Configuration](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/21\_parsing\_configuration.png)



\---



\### Step 23 — Account Schema



The account schema screen in SailPoint ISC — this is where each CSV column is mapped to a corresponding SailPoint account attribute.



!\[Account Schema](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/22\_account\_schema.png)



\---



\### Step 24 — Account Schema Edit Mode



Schema opened in edit mode to add and configure all required attributes from the HR CSV file.



!\[Schema Edit Mode](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/23\_account\_schema\_edit\_mode.png)



\---



\### Step 25 — Schema Updated



All CSV columns added to the schema — id, givenName, familyName, e-mail, department, title, employeeType, startDate, status — each mapped to the correct data type.



!\[Schema Updated](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/24\_schema\_updated.png)



\---



\### Step 26 — Account Schema Complete



Final schema review confirming all attributes are correctly defined and the anchor attribute (id) is properly set for identity correlation.



!\[Schema Complete](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/25\_account\_schema\_complete.png)



\---



\### Step 27 — Account Schema Full View



Full schema view showing all configured attributes in a single view — confirming the complete column mapping between the HR CSV and SailPoint.



!\[Schema Full View](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/26\_account\_schema\_full\_view.png)



\---



\### Step 28 — Account Correlation



Account correlation configuration — defining how SailPoint matches CSV records to existing identities to prevent duplicate identity creation on re-aggregation.



!\[Account Correlation](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/27\_account\_correlation.png)



\---



\### Step 29 — Add Criteria Clicked



Correlation criteria configuration screen opened — ready to define the matching rule between the CSV employee ID and the SailPoint identity attribute.



!\[Add Criteria](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/27\_add\_criteria\_clicked.png)



\---



\### Step 30 — Account Correlation Configured



Correlation rule set — employeeId from the CSV matched to the corresponding SailPoint identity attribute ensuring accurate identity linking on every aggregation run.



!\[Correlation Configured](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/27\_account\_correlation\_configured.png)



\---



\### Step 31 — Correlation Saved Success



Correlation rule saved successfully — SailPoint will now correctly match incoming CSV records to existing identities on every subsequent aggregation.



!\[Correlation Saved](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/28\_correlation\_saved\_success.png)



\---

\## Phase 3 — Identity Profile Configuration



\### Step 32 — Identity Profile Screen



The Identity Profile screen in SailPoint ISC — this is where the rules are defined for how raw account data gets transformed into a full identity record.



!\[Identity Profile Screen](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/29\_identity\_profile\_screen.png)



\---



\### Step 33 — Identity Profiles Page



The Identity Profiles list page showing the HR\_CSV\_Lab\_Identity\_Profile created for this project — the central configuration object that governs all identity lifecycle behavior.



!\[Identity Profiles Page](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/30\_identity\_profiles\_page.png)



\---



\### Step 34 — Create Identity Profile



New identity profile creation screen — naming the profile and linking it to the HR CSV source so SailPoint knows which source drives this profile.



!\[Create Identity Profile](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/31\_create\_identity\_profile.png)



\---



\### Step 35 — Mappings Username



Identity attribute mappings configured — the username attribute mapped to the employeeId from the CSV ensuring every identity gets a unique, consistent username.



!\[Mappings Username](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/34\_mappings\_username.png)



\---



\### Step 36 — Mappings Email Name Configured



Email and display name mappings configured — pulling givenName, familyName, and e-mail from the CSV and mapping them to the corresponding SailPoint identity attributes.



!\[Mappings Email](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/35\_mappings\_email\_name\_configured.png)



\---



\### Step 37 — Department And Employee ID



Department and Employee ID attribute mappings confirmed — ensuring these critical attributes populate correctly on every identity cube.



!\[Department And Employee ID](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/36\_department\_and\_employee\_ID.png)



\---



\### Step 38 — Start Date



Start Date attribute mapping configured — pulling the startDate column from the CSV and mapping it to the identity's start date field in SailPoint.



!\[Start Date](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/37\_start\_date.png)



\---



\### Step 39 — Title



Job title attribute mapping configured — pulling the title column from the CSV and mapping it to the identity's job title field.



!\[Title](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/38\_Title.png)



\---



\### Step 40 — Identity Profile Status



Identity profile status confirmed as active — the profile is live and will govern all identity creation and lifecycle events from the HR CSV source.



!\[Identity Profile Status](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/39\_identity\_profile\_status.png)



\---



\### Step 41 — HR Source CSV Updated Family Name



Family name attribute mapping updated — correcting the column reference to ensure lastName populates correctly on all identity cubes.



!\[CSV Updated Family Name](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/40\_hr\_source\_csv\_updated\_familyName.png)



\---



\## Phase 4 — Aggregation



\### Step 42 — Aggregation Started



First aggregation run initiated — SailPoint connecting to the Rebex SFTP server to retrieve the HR CSV file and begin processing identity records.



!\[Aggregation Started](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/41\_aggregation\_started.png)



\---



\### Step 43 — Aggregation Results



Initial aggregation results — confirming SailPoint successfully read and processed the HR CSV file. This was the first proof that the entire source pipeline was working correctly.



!\[Aggregation Results](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/42\_aggregation\_results.png)



\---



\### Step 44 — Three Accounts Created



Three identity records created from the initial aggregation — James Carter (JG9001), Maria Santos (JG9002), and Derek Williams (JG9003) all successfully ingested from the HR CSV.



!\[Three Accounts Created](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/43\_three\_accounts\_created.png)



\---



\### Step 45 — Rebex Connection Settings



Rebex Tiny SFTP Server configuration panel — showing the server running on the local Windows machine at 192.168.50.91 port 22 with the correct folder path configured.



!\[Rebex Connection Settings](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/44\_rebex\_connection\_settings.png)



\---



\### Step 46 — Aggregation Run 2 Started



Second aggregation run initiated after CSV schema corrections — verifying the updated column mappings resolved the incomplete identity issues.



!\[Aggregation Run 2](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/45\_aggregation\_run2\_started.png)



\---



\### Step 47 — Aggregation V2 Success



Second aggregation completed successfully — all three identities now showing complete attribute data after the schema mapping corrections.



!\[Aggregation V2 Success](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/45\_aggregationV2\_success.png)



\---



\### Step 48 — Aggregation Success



Final confirmation of successful aggregation — Objects Scanned: 3, Status: Success. The HR source pipeline is fully operational.



!\[Aggregation Success](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/45\_aggregation\_success.png)



\---



\## Phase 5 — Identity Verification



\### Step 49 — James Carter Identity Cube



James Carter's identity cube in SailPoint ISC — showing all attributes successfully populated from the HR CSV source including department, title, email, and employee ID.



!\[James Carter Identity Cube](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/46\_james\_carter\_identity\_cube.png)



\---



\### Step 50 — James Carter Identity Found



James Carter confirmed as a Human Identity in SailPoint ISC — proving the correlation rule correctly linked the CSV account to a full identity record.



!\[James Carter Found](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/46\_james\_carter\_identity\_found.png)



\---



\### Step 51 — James Carter Identity Cube Verified



James Carter's complete identity cube — all attributes verified and populated. First identity confirmed complete after schema and mapping corrections.



!\[James Carter Complete](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/47\_james\_carter\_identity\_cube.png)



\---



\### Step 52 — James Carter Complete



James Carter identity fully verified — all required attributes present, no incomplete status, identity ready for lifecycle event processing.



!\[James Carter Verified](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/48\_james\_carter\_complete.png)



\---



\### Step 53 — Maria Santos Complete



Maria Santos (JG9002) identity cube verified — all attributes populated correctly including Finance department, Financial Analyst title, and correct email address.



!\[Maria Santos Complete](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/49\_maria\_santos\_complete.png)



\---



\### Step 54 — Derek Williams Complete



Derek Williams (JG9003) identity cube verified — all attributes populated correctly including IT department, Systems Administrator title, and correct email address. All three original identities confirmed complete.



!\[Derek Williams Complete](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/50\_derek\_williams\_complete.png)



\---



\## Phase 6 — Lifecycle Management



\### Step 55 — Lifecycle Management



The Lifecycle Management screen inside the HR\_CSV\_Lab\_Identity\_Profile — showing the available lifecycle states including Active, Archived, Leave of Absence, Pre Hire, and Terminated.



!\[Lifecycle Management](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/51\_lifecycle\_management.png)



\---



\### Step 56 — Active Lifecycle Enabled



The Active lifecycle state enabled — toggle switched on and Apply Changes executed successfully. SailPoint will now enforce the Active state rulebook on all new joiner identities.



!\[Active Lifecycle Enabled](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/52\_active\_lifecycle\_enabled.png)



\---



\## Phase 7 — Joiner Workflow



\### Step 57 — Joiner Workflow Canvas



The completed Joiner workflow canvas in SailPoint ISC Workflow Builder — showing the full automation chain: Trigger (Identity Created) → Action (Send Email) → Operator (End Step Success). Built from scratch with zero validation errors.



!\[Joiner Workflow Canvas](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/53\_joiner\_workflow\_canvas.png)



\---



\### Step 58 — Workflow Test Setup



Joiner workflow test setup screen — showing the complete workflow chain on the left canvas and the JSON test input panel on the right. Demonstrates the workflow is valid and ready for live testing.



!\[Workflow Test Setup](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/54\_workflow\_test\_setup.png)



\---



\### Step 59 — Workflow Enabled



Joiner workflow status changed to Enabled (green) in the SailPoint ISC workflow list — the automation is now live and listening for new identity creation events.



!\[Workflow Enabled](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/55\_workflow\_enabled.png)



\---



\### Step 60 — Aggregation 4 Objects Scanned



Fourth employee (Sarah Mitchell — JG9004) added to the HR CSV and aggregation run — Objects Scanned: 4, Status: Success. SailPoint detected the new identity and the Joiner workflow fired automatically.



!\[4 Objects Scanned](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/56\_aggregation\_4\_objects\_scanned.png)



\---



\### Step 61 — Joiner Workflow Execution



Joiner workflow execution log showing Status: Complete — confirming the workflow fired automatically in response to the new identity creation event triggered by the aggregation.



!\[Joiner Execution](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/57\_joiner\_workflow\_execution.png)



\---



\## Phase 8 — Leaver Workflow



\### Step 62 — Terminated Lifecycle Enabled



The Terminated lifecycle state enabled in the HR\_CSV\_Lab\_Identity\_Profile — Remove All Access toggle confirmed on, ensuring all access is automatically revoked when an identity enters the Terminated state.



!\[Terminated Lifecycle](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/58\_terminated\_lifecycle\_enabled.png)



\---



\### Step 63 — Joiner Email Proof



Email notification received in inbox from no-reply@sailpoint.com — confirming the Joiner workflow fired successfully and the email action executed correctly end to end.



!\[Joiner Email Proof](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/58b\_joiner\_email\_proof.png)



\---



\### Step 64 — Leaver Workflow Canvas



The completed Leaver workflow canvas — showing the full automation chain: Trigger (Identity Lifecycle State Changed) → Action (Send Email) → Operator (End Step Success). Built from scratch mirroring the Joiner workflow structure.



!\[Leaver Workflow Canvas](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/59\_leaver\_workflow\_canvas.png)



\---



\### Step 65 — Leaver Workflow Enabled



Leaver workflow status changed to Enabled (green) — the offboarding automation is now live and listening for terminated lifecycle state change events.



!\[Leaver Workflow Enabled](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/60\_leaver\_workflow\_enabled.png)



\---



\### Step 66 — Leaver Aggregation Success



Aggregation run after Sarah Mitchell's status changed to terminated in the HR CSV — Objects Scanned: 4, Status: Success. SailPoint detected the lifecycle state change.



!\[Leaver Aggregation](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/61\_leaver\_aggregation\_success.png)



\---



\### Step 67 — Leaver Aggregation Success Confirmed



Second aggregation confirmation showing the terminated status change successfully processed — SailPoint moving Sarah Mitchell's identity into the Terminated lifecycle state.



!\[Leaver Aggregation Confirmed](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/62\_leaver\_aggregation\_success.png)



\---



\### Step 68 — Sarah Mitchell Terminated



Sarah Mitchell's identity cube showing Lifecycle State: terminated — confirming SailPoint successfully detected the status change from the HR CSV and moved her identity to the Terminated state automatically.



!\[Sarah Mitchell Terminated](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/63\_sarah\_mitchell\_terminated.png)



\---



\### Step 69 — Leaver Workflow Execution



Leaver workflow execution log showing 2 results, Status: Complete — confirming the workflow fired automatically in response to the terminated lifecycle state change event.



!\[Leaver Execution](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/64\_leaver\_workflow\_execution.png)



\---



\### Step 70 — Leaver Email Proof



Email notification received from no-reply@sailpoint.com with subject "Leaver Alert" — confirming the Leaver workflow fired successfully and the offboarding notification was delivered end to end.



!\[Leaver Email Proof](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/65\_leaver\_email\_proof.png)



\---



\### Step 71 — Leaver Email Proof Clean



Clean Leaver email notification showing real employee data — confirming the full offboarding automation pipeline working end to end with accurate identity information.



!\[Leaver Email Clean](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/65b\_leaver\_email\_proof\_clean.png)



\---



\### Step 72 — Joiner Email Proof Clean



Clean Joiner email notification showing James Carter's real employee data — Name, Employee ID, Department, Title, and Start Date all correctly populated from the SailPoint identity cube.



!\[Joiner Email Clean](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/66\_joiner\_email\_proof\_clean.png)



\---



\## Phase 9 — Mover Workflow



\### Step 73 — Mover Workflow Canvas



The completed Mover workflow canvas — showing the full automation chain: Trigger (Identity Attributes Changed) → Action (Send Email) → Operator (End Step Success). The Mover completes the full JML pipeline.



!\[Mover Workflow Canvas](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/67\_mover\_workflow\_canvas.png)



\---



\### Step 74 — Mover Workflow Enabled



Mover workflow status changed to Enabled (green) — the department transfer automation is now live and listening for identity attribute change events.



!\[Mover Workflow Enabled](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/68\_mover\_workflow\_enabled.png)



\---



\### Step 75 — Mover Aggregation Success



Aggregation run after James Carter's department changed from Engineering to IT in the HR CSV — Objects Scanned: 5, Status: Success. SailPoint detected the attribute change.



!\[Mover Aggregation](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/69\_mover\_aggregation\_success.png)



\---



\### Step 76 — Mover Workflow Execution



Mover workflow execution log showing Status: Complete — confirming the workflow fired automatically in response to James Carter's department attribute change event.



!\[Mover Execution](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/70\_mover\_workflow\_execution.png)



\---



\### Step 77 — Mover Email Proof



Email notification received confirming James Carter's department transfer from Engineering to IT — the Mover automation pipeline working end to end. Full JML pipeline complete.



!\[Mover Email Proof](/JustinGallimore/sailpoint-jml-pipeline/raw/main/Screenshots/71\_mover\_email\_proof.png)



\---



\## Pipeline Complete



All three JML automation events successfully demonstrated:



| Event | Identity | Trigger | Status |

|---|---|---|---|

| Joiner | Marcus Thompson | Identity Created | ✅ Complete |

| Mover | James Carter | Identity Attributes Changed | ✅ Complete |

| Leaver | Sarah Mitchell | Identity Lifecycle State Changed | ✅ Complete |



\---



\*Visual walkthrough authored by Justin Gallimore — IAM Engineer\*

\*SailPoint ISC JML Automation Pipeline — April 2026\*

