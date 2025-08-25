# بنيان - سكريپت النشر الشامل
# Bunyan Multi-Platform Deployment Script (PowerShell)

Write-Host "🚀 بدء عملية النشر الشامل لمنصة بنيان" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan

function Print-Step {
    param($Message)
    Write-Host "📋 $Message" -ForegroundColor Blue
}

function Print-Success {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Print-Error {
    param($Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Print-Warning {
    param($Message)
    Write-Host "⚠️ $Message" -ForegroundColor Yellow
}

# Check if Flutter is installed
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Print-Error "Flutter غير مثبت! يرجى تثبيت Flutter أولاً"
    exit 1
}

Print-Success "Flutter موجود ✓"

# Main app deployment
Print-Step "بناء التطبيق الرئيسي..."
flutter clean
flutter pub get
flutter build web --release
if ($LASTEXITCODE -eq 0) {
    Print-Success "تم بناء التطبيق الرئيسي بنجاح"
} else {
    Print-Error "فشل في بناء التطبيق الرئيسي"
    exit 1
}

# Client app deployment
Print-Step "بناء تطبيق العملاء..."
Set-Location "apps\client_web"
flutter clean
flutter pub get
flutter build web --release
if ($LASTEXITCODE -eq 0) {
    Print-Success "تم بناء تطبيق العملاء بنجاح"
    Set-Location "..\..\"
} else {
    Print-Error "فشل في بناء تطبيق العملاء"
    exit 1
}

# Supplier app deployment
Print-Step "بناء تطبيق الموردين..."
Set-Location "apps\supplier_web"
flutter clean
flutter pub get
flutter build web --release
if ($LASTEXITCODE -eq 0) {
    Print-Success "تم بناء تطبيق الموردين بنجاح"
    Set-Location "..\..\"
} else {
    Print-Error "فشل في بناء تطبيق الموردين"
    exit 1
}

# Console app deployment
Print-Step "بناء وحدة التحكم..."
Set-Location "apps\console_web"
flutter clean
flutter pub get
flutter build web --release
if ($LASTEXITCODE -eq 0) {
    Print-Success "تم بناء وحدة التحكم بنجاح"
    Set-Location "..\..\"
} else {
    Print-Error "فشل في بناء وحدة التحكم"
    exit 1
}

Print-Success "🎉 تم بناء جميع التطبيقات بنجاح!"

# Display deployment information
Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "📊 معلومات النشر:" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "1️⃣ التطبيق الرئيسي: build\web"
Write-Host "2️⃣ تطبيق العملاء: apps\client_web\build\web"
Write-Host "3️⃣ تطبيق الموردين: apps\supplier_web\build\web"
Write-Host "4️⃣ وحدة التحكم: apps\console_web\build\web"
Write-Host ""

# Netlify deployment suggestions
Write-Host "🌐 اقتراحات النشر على Netlify:" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "للتطبيق الرئيسي:"
Write-Host "netlify deploy --prod --dir build\web"
Write-Host ""
Write-Host "لتطبيق العملاء:"
Write-Host "netlify deploy --prod --dir apps\client_web\build\web --site [client-site-id]"
Write-Host ""
Write-Host "لتطبيق الموردين:"
Write-Host "netlify deploy --prod --dir apps\supplier_web\build\web --site [supplier-site-id]"
Write-Host ""
Write-Host "لوحدة التحكم:"
Write-Host "netlify deploy --prod --dir apps\console_web\build\web --site [console-site-id]"
Write-Host ""

Print-Warning "تأكد من استبدال [site-id] بمعرف الموقع الفعلي من Netlify"

# File sizes
Print-Step "أحجام الملفات المبنية:"
try {
    $mainSize = (Get-ChildItem -Path "build\web" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "التطبيق الرئيسي: $([math]::Round($mainSize, 2)) MB"
} catch {
    Write-Host "التطبيق الرئيسي: N/A"
}

try {
    $clientSize = (Get-ChildItem -Path "apps\client_web\build\web" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "تطبيق العملاء: $([math]::Round($clientSize, 2)) MB"
} catch {
    Write-Host "تطبيق العملاء: N/A"
}

try {
    $supplierSize = (Get-ChildItem -Path "apps\supplier_web\build\web" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "تطبيق الموردين: $([math]::Round($supplierSize, 2)) MB"
} catch {
    Write-Host "تطبيق الموردين: N/A"
}

try {
    $consoleSize = (Get-ChildItem -Path "apps\console_web\build\web" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "وحدة التحكم: $([math]::Round($consoleSize, 2)) MB"
} catch {
    Write-Host "وحدة التحكم: N/A"
}

Write-Host ""
Print-Success "✨ جاهز للنشر! راجع دليل النشر في DEPLOYMENT_GUIDE.md للمزيد من التفاصيل"
