Add-Type -AssemblyName System.Drawing
$dist = "C:\Users\Administrator\Documents\默认项目\html5-slot-machine\dist"
$imgDir = Join-Path $dist "img"
if (-not (Test-Path $imgDir)) { New-Item -ItemType Directory -Path $imgDir | Out-Null }

$bgColor = [System.Drawing.Color]::FromArgb(15, 23, 42)
$accentColor = [System.Drawing.Color]::FromArgb(245, 158, 11)
$textColor = [System.Drawing.Color]::FromArgb(248, 250, 252)
$mutedColor = [System.Drawing.Color]::FromArgb(203, 213, 225)

# OG image 1200x630
$bmp = [System.Drawing.Bitmap]::new(1200, 630)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias
$rect = [System.Drawing.Rectangle]::new(0, 0, 1200, 630)
$grad = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, $bgColor, [System.Drawing.Color]::FromArgb(30, 41, 59), 45.0)
$g.FillRectangle($grad, $rect)
$glow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(28, 245, 158, 11))
$g.FillEllipse($glow, 780, 60, 560, 560)
$accent = [System.Drawing.SolidBrush]::new($accentColor)
$g.FillRectangle($accent, 0, 0, 1200, 8)
$fontTitle = [System.Drawing.Font]::new("Arial", 72, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$textBrush = [System.Drawing.SolidBrush]::new($textColor)
$g.DrawString("HTML5 Slot Machine", $fontTitle, $textBrush, 80, 190)
$fontSub = [System.Drawing.Font]::new("Arial", 34, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$accentText = [System.Drawing.SolidBrush]::new($accentColor)
$g.DrawString("Free Online Casino Slots", $fontSub, $accentText, 80, 290)
$fontDesc = [System.Drawing.Font]::new("Arial", 24, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$mutedBrush = [System.Drawing.SolidBrush]::new($mutedColor)
$g.DrawString("No download  |  No signup  |  Desktop & mobile", $fontDesc, $mutedBrush, 80, 360)
$fontIcon = [System.Drawing.Font]::new("Segoe UI Emoji", 200, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString([char]::ConvertFromUtf32(0x1F3B0), $fontIcon, $textBrush, 800, 200)
$fontUrl = [System.Drawing.Font]::new("Consolas", 22, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString("slotmachine.vip01.cc.cd", $fontUrl, $mutedBrush, 80, 520)
$g.Dispose()
$bmp.Save((Join-Path $imgDir "og-image.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "Generated og-image.png"

# Favicon 32
$bmp = [System.Drawing.Bitmap]::new(32, 32)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.Clear($bgColor)
$brush = [System.Drawing.SolidBrush]::new($accentColor)
$g.FillEllipse($brush, 4, 4, 24, 24)
$font = [System.Drawing.Font]::new("Arial", 20, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$g.DrawString("7", $font, [System.Drawing.SolidBrush]::new($bgColor), 8, 4)
$g.Dispose()
$bmp.Save((Join-Path $imgDir "favicon-32.png"), [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Host "Generated favicon-32.png"

# Copy _headers to dist
Copy-Item -Path "C:\Users\Administrator\Documents\默认项目\html5-slot-machine\_headers" -Destination (Join-Path $dist "_headers") -Force
Write-Host "Copied _headers"
Get-ChildItem $imgDir -File | Select-Object Name, Length | Format-Table -AutoSize
