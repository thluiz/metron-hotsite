# deploy.ps1 — Build and sync metron-hotsite to S3 + invalidate CloudFront
param([switch]$BuildOnly)

Set-Location $PSScriptRoot

Write-Host "Building..." -ForegroundColor Cyan
npm run build
if ($LASTEXITCODE -ne 0) { Write-Error "Build failed"; exit 1 }

if ($BuildOnly) { Write-Host "Build only — skipping deploy."; exit 0 }

Write-Host "Syncing to S3..." -ForegroundColor Cyan
aws --profile scholion-admin s3 sync dist/ s3://metron-hotsite-thluiz-com/ --delete
if ($LASTEXITCODE -ne 0) { Write-Error "S3 sync failed"; exit 1 }

Write-Host "Invalidating CloudFront..." -ForegroundColor Cyan
aws --profile scholion-admin cloudfront create-invalidation `
  --distribution-id E3DJ3AFXNDSS29 `
  --paths "/*" | ConvertFrom-Json | Select-Object -ExpandProperty Invalidation | Select-Object Id, Status

Write-Host "Done. Site: https://metron-hotsite.thluiz.com" -ForegroundColor Green
