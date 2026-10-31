# deploy-slot.ps1 - HTML5 Slot Machine 一键部署脚本
# 用法: .\deploy-slot.ps1 [-Token <API_TOKEN>] [-Account <ACCOUNT_ID>]
param(
    [string]$Token = $env:CLOUDFLARE_API_TOKEN,
    [string]$Account = $env:CLOUDFLARE_ACCOUNT_ID
)

$ErrorActionPreference = "Stop"

if (-not $Token -or -not $Account) {
    Write-Host "请设置环境变量 CLOUDFLARE_API_TOKEN 和 CLOUDFLARE_ACCOUNT_ID" -ForegroundColor Red
    exit 1
}

$projectName = "slotmachine-casino"
$workDir = $PSScriptRoot

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  HTML5 Slot Machine - Cloudflare Pages 部署" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Build
Write-Host "`n[1/4] 构建项目..." -ForegroundColor Yellow
$env:Path = "C:\Program Files\nodejs;" + $env:Path
Push-Location $workDir
& npm run build 2>&1 | Select-Object -Last 3
if ($LASTEXITCODE -ne 0) { Write-Host "构建失败" -ForegroundColor Red; exit 1 }

# 2. Copy extra files to dist
Write-Host "`n[2/4] 复制额外文件..." -ForegroundColor Yellow
Copy-Item -Path "_headers" -Destination "dist\_headers" -Force
Copy-Item -Path "robots.txt" -Destination "dist\robots.txt" -Force -ErrorAction SilentlyContinue
Copy-Item -Path "sitemap.xml" -Destination "dist\sitemap.xml" -Force -ErrorAction SilentlyContinue

# 3. Deploy
Write-Host "`n[3/4] 部署到 Cloudflare Pages..." -ForegroundColor Yellow
$env:CLOUDFLARE_API_TOKEN = $Token
$env:CLOUDFLARE_ACCOUNT_ID = $Account
& npx --yes wrangler@latest pages deploy dist --project-name=$projectName --branch=main 2>&1 | Select-Object -Last 4

# 4. Verify
Write-Host "`n[4/4] 验证部署..." -ForegroundColor Yellow
Start-Sleep -Seconds 5
$prodUrl = "https://slotmachine.vip01.cc.cd/"
try {
    $r = Invoke-WebRequest -Uri $prodUrl -UseBasicParsing -TimeoutSec 15
    Write-Host "生产站点: HTTP $($r.StatusCode) ($($r.Content.Length) bytes)" -ForegroundColor Green
} catch {
    Write-Host "验证失败: $($_.Exception.Message)" -ForegroundColor Yellow
}

Pop-Location
Write-Host "`n部署完成！" -ForegroundColor Green
Write-Host "生产 URL: $prodUrl" -ForegroundColor Cyan