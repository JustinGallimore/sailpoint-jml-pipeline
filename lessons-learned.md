# Lessons Learned

## sailpoint-jml-pipeline

This document covers what broke during the build, what caused it, how it was fixed, and what the production equivalent would look like. These are not hypothetical scenarios. Every issue here happened in a live lab environment and required real troubleshooting to resolve.

---

## Issue 01: SailPoint Virtual Appliance Network Isolation from DC01

**What broke:**

The SailPoint Virtual Appliance was originally deployed in VirtualBox while DC01 was running in VMware Workstation. Both were configured with bridged networking but the VA and DC01 could not reach each other. Source connectivity tests failed and aggregations timed out.

**Root cause:**

VirtualBox and VMware use separate virtual network stacks that do not share the same bridged network segment even when both are set to bridged mode on the same physical host. Traffic from the VirtualBox VA bridged to the host adapter was not visible to the VMware network bridge and vice versa. The two hypervisors were operating in network isolation despite appearing to be on the same physical network.

**How it was fixed:**

The VA was fully migrated from VirtualBox to VMware Workstation. This required converting the VDI disk image to VMDK format and rebuilding the VM in VMware from the converted disk. After migration both the VA and DC01 were on the same VMware virtual network and connectivity was restored immediately.

**What production looks like:**

In a production environment the SailPoint VA runs on dedicated infrastructure — typically a VMware ESXi host or a cloud VM — that is on the same network segment as the Active Directory domain controllers and any connected sources. Network isolation is never an issue because the VA is provisioned on the same infrastructure platform as everything else it needs to reach.

---

## Issue 02: Leaver Workflow Silently Not Firing

**What broke:**

The Joiner and Mover workflows tested successfully. When the Leaver test was run by updating the identity's lifecycle state to terminated in the HR CSV source, no workflow fired. The identity sat in a terminated state with no access changes. There were no errors in the workflow logs — the workflow simply never triggered.

**Root cause:**

The Lifecycle State Mapping in the source configuration was empty. SailPoint ISC requires an explicit mapping between the raw value coming from the source and a recognized ISC lifecycle state. Without that mapping ISC receives the terminated value from the CSV but does not know what lifecycle state to transition the identity into. Because no lifecycle state change was registered, the Leaver workflow trigger condition was never met and the workflow never fired.

**How it was fixed:**

The Lifecycle State Mapping was configured in the source settings to map the raw CSV value terminated to the ISC lifecycle state terminated. After saving the mapping and re-aggregating the source the lifecycle state change registered correctly and the Leaver workflow fired as expected.

**What production looks like:**

In production this mapping is part of the source design process and is documented in the connector configuration specification before the source goes live. An empty lifecycle state mapping in production means leaver events silently fail — a serious gap that would allow terminated employees to retain access indefinitely without any errors appearing in logs.

---

## Issue 03: Incorrect JSONPath Filter Syntax Blocking Workflow Triggers

**What broke:**

After the lifecycle state mapping was configured the Leaver workflow still did not fire on the first attempt. The workflow trigger was configured but the event filter was not matching the lifecycle state change event.

**Root cause:**

The JSONPath filter syntax used in the workflow trigger condition was incorrect. The filter needs to reference the changes array in the identity event payload and match on the lifecycleState field specifically. An incorrect filter expression means the trigger evaluates the event payload and finds no match, so the workflow never starts.

**How it was fixed:**

The correct JSONPath filter syntax for lifecycle state change triggers in SailPoint ISC is:

```
$.changes[?(@.lifecycleState == "terminated")]
```

After updating the trigger condition with the correct syntax the workflow fired correctly on the next test.

**What production looks like:**

In production workflow trigger filters are validated during the design and testing phase before the workflow is enabled. Incorrect filter syntax is one of the most common causes of workflows that appear configured correctly but never fire. The fix is always to validate the filter against the actual event payload structure that ISC generates.

---

## What I Would Do Differently in Production

Testing each lifecycle workflow individually before enabling all three saved significant debugging time. In production I would follow the same pattern — enable and validate Joiner first, then Mover, then Leaver — rather than enabling all workflows simultaneously and trying to isolate failures across multiple triggers at once.

The lifecycle state mapping would be documented and validated as part of the source acceptance criteria before go-live. A blank mapping should be treated as a blocking defect, not a configuration gap to fix post-deployment.

All workflow trigger filters would be reviewed against the ISC event payload schema before the workflow is enabled in production to catch syntax issues before they cause silent failures.

---

*Built by Justin Gallimore | [github.com/JustinGallimore](https://github.com/JustinGallimore)*
