# =============================================================================
# Invoke_SailPoint_Aggregation.ps1
# Author: Justin Gallimore
# Description: Authenticates to SailPoint IdentityNow (ISC) using OAuth2 client
#              credentials and triggers a manual aggregation on a specified source.
#              In a production JML pipeline this would be scheduled or event-driven
#              to ensure identity data stays in sync with the HR system of record.
# =============================================================================

# -----------------------------------------------------------------------------
# CONFIGURATION
# Replace these placeholder values with your actual SailPoint ISC tenant details.
# In production these would be pulled from a secrets manager or environment
# variables — never hardcoded in the script itself.
# -----------------------------------------------------------------------------
$TenantURL    = "https://YOUR-TENANT.api.identitynow.com"   # Your ISC tenant API base URL
$ClientID     = "YOUR_CLIENT_ID"                             # OAuth2 client ID from ISC admin panel
$ClientSecret = "YOUR_CLIENT_SECRET"                         # OAuth2 client secret — treat like a password
$SourceID     = "YOUR_SOURCE_ID"                             # The source ID for your HR CSV source in ISC

# -----------------------------------------------------------------------------
# STEP 1: AUTHENTICATE — GET AN ACCESS TOKEN
# SailPoint ISC uses OAuth2 client credentials flow for API authentication.
# We POST our client ID and secret to the token endpoint and get back a
# bearer token that authorizes all subsequent API calls.
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
# All subsequent API requests need the bearer token in the Authorization header.
# This is standard OAuth2 — the token proves we are an authorized API client.
# -----------------------------------------------------------------------------
$Headers = @{
    Authorization  = "Bearer $AccessToken"
    "Content-Type" = "application/json"
}

# -----------------------------------------------------------------------------
# STEP 3: TRIGGER THE AGGREGATION
# This calls the ISC Accounts API to kick off a full aggregation on the source.
# A full aggregation pulls all account data from the connected source (in this
# lab, the CSV file over SFTP) and reconciles it against what ISC already knows.
# This is what drives joiner and mover events when identity data changes.
# -----------------------------------------------------------------------------
Write-Host "[*] Triggering full aggregation on Source ID: $SourceID..." -ForegroundColor Cyan

$AggregationURL = "$TenantURL/beta/sources/$SourceID/load-accounts"

$AggregationBody = @{
    disableOptimization = $false   # Set to $true to force a full re-import even if no changes detected
} | ConvertTo-Json

try {
    $AggregationResponse = Invoke-RestMethod -Uri $AggregationURL -Method POST -Headers $Headers -Body $AggregationBody
    Write-Host "[+] Aggregation triggered successfully." -ForegroundColor Green
    Write-Host "[+] Task ID: $($AggregationResponse.id)"
    Write-Host "[+] Status:  $($AggregationResponse.status)"
}
catch {
    Write-Host "[-] Aggregation request failed." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}

# -----------------------------------------------------------------------------
# STEP 4: OUTPUT SUMMARY
# Log a summary so there is a clear record of what ran and when.
# In production this output would typically be captured in a SIEM or log file.
# -----------------------------------------------------------------------------
Write-Host ""
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host " Aggregation Summary" -ForegroundColor Yellow
Write-Host "=============================================" -ForegroundColor Yellow
Write-Host " Tenant   : $TenantURL"
Write-Host " Source ID: $SourceID"
Write-Host " Task ID  : $($AggregationResponse.id)"
Write-Host " Timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "=============================================" -ForegroundColor Yellow
