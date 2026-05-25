# =============================================================================
# Get_Identity_Lifecycle_State.ps1
# Author: Justin Gallimore
# Description: Authenticates to SailPoint IdentityNow (ISC) using OAuth2 client
#              credentials, queries a specific identity by name or ID, and returns
#              their current lifecycle state and key attributes.
#              In a JML pipeline this is used to validate that a lifecycle event
#              fired correctly — confirming a joiner moved to "active", a mover
#              updated their department, or a leaver transitioned to "terminated".
# =============================================================================

# -----------------------------------------------------------------------------
# CONFIGURATION
# Replace these placeholder values with your actual SailPoint ISC tenant details.
# In production these would be stored in a secrets manager or passed as
# environment variables — never hardcoded in the script.
# -----------------------------------------------------------------------------
$TenantURL    = "https://YOUR-TENANT.api.identitynow.com"   # Your ISC tenant API base URL
$ClientID     = "YOUR_CLIENT_ID"                             # OAuth2 client ID from ISC admin panel
$ClientSecret = "YOUR_CLIENT_SECRET"                         # OAuth2 client secret — treat like a password
$IdentityName = "YOUR_IDENTITY_NAME"                         # The display name of the identity to look up
                                                             # Example: "john.smith" or "Jane Doe"

# -----------------------------------------------------------------------------
# STEP 1: AUTHENTICATE — GET AN ACCESS TOKEN
# SailPoint ISC uses OAuth2 client credentials flow for API authentication.
# We exchange our client ID and secret for a short-lived bearer token that
# authorizes all subsequent API calls in this session.
# -----------------------------------------------------------------------------
Write-Host "[*] Requesting OAuth2 access token from SailPoint ISC..." -ForegroundColor Cyan

$TokenURL = "$TenantURL/oauth/token"

$TokenBody = @{
    grant_type    = "client_credentials"
    client_id     = $ClientID
    client_secret = $ClientSecret
}

try {
    $TokenResponse = Invoke-RestMethod -Uri $TokenURL -Method POST -Body $TokenBody -ContentType "application/x-www-form-urlencoded"
    $AccessToken = $TokenResponse.access_token
    Write-Host "[+] Access token retrieved successfully." -ForegroundColor Green
}
catch {
    Write-Host "[-] Failed to retrieve access token. Check your tenant URL, client ID, and client secret." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}

# -----------------------------------------------------------------------------
# STEP 2: BUILD THE AUTH HEADER
# Every API call after authentication needs the bearer token in the header.
# Without this, ISC will return a 401 Unauthorized and reject the request.
# -----------------------------------------------------------------------------
$Headers = @{
    Authorization  = "Bearer $AccessToken"
    "Content-Type" = "application/json"
}

# -----------------------------------------------------------------------------
# STEP 3: QUERY THE IDENTITY
# We use the ISC Identities API with a filter to find the identity by name.
# The filter syntax follows JSONPath-style expressions that ISC supports natively.
# We request the full identity object so we can pull lifecycle state and
# other relevant attributes from the response.
# -----------------------------------------------------------------------------
Write-Host "[*] Querying identity: $IdentityName..." -ForegroundColor Cyan

$IdentityURL = "$TenantURL/v3/identities?filters=name%20eq%20%22$IdentityName%22"

try {
    $IdentityResponse = Invoke-RestMethod -Uri $IdentityURL -Method GET -Headers $Headers
}
catch {
    Write-Host "[-] Failed to query identity. Check the identity name and your API permissions." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}

# -----------------------------------------------------------------------------
# STEP 4: VALIDATE RESULTS
# If the query returns no results the identity does not exist in ISC, which
# itself could indicate a pipeline issue — for example a joiner that never
# got created, or a leaver that was already removed from the source.
# -----------------------------------------------------------------------------
if ($IdentityResponse.Count -eq 0) {
    Write-Host "[-] No identity found with the name: $IdentityName" -ForegroundColor Red
    Write-Host "    This may mean the identity has not been aggregated yet, or the name is incorrect."
    exit 1
}

$Identity = $IdentityResponse[0]

# -----------------------------------------------------------------------------
# STEP 5: EXTRACT AND DISPLAY LIFECYCLE STATE
# The lifecycleState field is what drives JML workflow triggers in ISC.
# Common values in this lab: "active" (joiner), "terminated" (leaver).
# Mover events are triggered by attribute changes rather than state changes.
# -----------------------------------------------------------------------------
Write-Host "[+] Identity found." -ForegroundColor Green
Write-Host ""
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host " Identity Lifecycle State Report" -ForegroundColor Yellow
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host " Name            : $($Identity.name)"
Write-Host " ID              : $($Identity.id)"
Write-Host " Display Name    : $($Identity.displayName)"
Write-Host " Email           : $($Identity.email)"
Write-Host " Lifecycle State : $($Identity.lifecycleState)"
Write-Host " Is Manager      : $($Identity.isManager)"
Write-Host " Status          : $($Identity.status)"
Write-Host " Created         : $($Identity.created)"
Write-Host " Modified        : $($Identity.modified)"
Write-Host " Timestamp       : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host ""

# -----------------------------------------------------------------------------
# STEP 6: LIFECYCLE STATE VALIDATION
# This block checks whether the identity is in an expected lifecycle state
# and flags anything that looks off. In production this would feed into
# an alerting system or access review workflow.
# -----------------------------------------------------------------------------
switch ($Identity.lifecycleState) {
    "active" {
        Write-Host "[+] Lifecycle state is ACTIVE — identity is a current employee with access." -ForegroundColor Green
    }
    "terminated" {
        Write-Host "[!] Lifecycle state is TERMINATED — leaver workflow should have fired." -ForegroundColor Yellow
        Write-Host "    Verify access has been removed and accounts have been disabled."
    }
    "inactive" {
        Write-Host "[!] Lifecycle state is INACTIVE — identity exists but may not have active access." -ForegroundColor Yellow
    }
    default {
        Write-Host "[?] Lifecycle state is: $($Identity.lifecycleState) — review this manually." -ForegroundColor Magenta
    }
}
