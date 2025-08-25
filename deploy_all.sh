#!/bin/bash

# بنيان - سكريبت النشر الشامل
# Bunyan Multi-Platform Deployment Script

echo "🚀 بدء عملية النشر الشامل لمنصة بنيان"
echo "=================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_step() {
    echo -e "${BLUE}📋 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter غير مثبت! يرجى تثبيت Flutter أولاً"
    exit 1
fi

print_success "Flutter موجود ✓"

# Main app deployment
print_step "بناء التطبيق الرئيسي..."
flutter clean
flutter pub get
flutter build web --release
if [ $? -eq 0 ]; then
    print_success "تم بناء التطبيق الرئيسي بنجاح"
else
    print_error "فشل في بناء التطبيق الرئيسي"
    exit 1
fi

# Client app deployment
print_step "بناء تطبيق العملاء..."
cd apps/client_web
flutter clean
flutter pub get
flutter build web --release
if [ $? -eq 0 ]; then
    print_success "تم بناء تطبيق العملاء بنجاح"
    cd ../..
else
    print_error "فشل في بناء تطبيق العملاء"
    exit 1
fi

# Supplier app deployment
print_step "بناء تطبيق الموردين..."
cd apps/supplier_web
flutter clean
flutter pub get
flutter build web --release
if [ $? -eq 0 ]; then
    print_success "تم بناء تطبيق الموردين بنجاح"
    cd ../..
else
    print_error "فشل في بناء تطبيق الموردين"
    exit 1
fi

# Console app deployment
print_step "بناء وحدة التحكم..."
cd apps/console_web
flutter clean
flutter pub get
flutter build web --release
if [ $? -eq 0 ]; then
    print_success "تم بناء وحدة التحكم بنجاح"
    cd ../..
else
    print_error "فشل في بناء وحدة التحكم"
    exit 1
fi

print_success "🎉 تم بناء جميع التطبيقات بنجاح!"

# Display deployment information
echo ""
echo "=================================="
echo "📊 معلومات النشر:"
echo "=================================="
echo "1️⃣ التطبيق الرئيسي: build/web"
echo "2️⃣ تطبيق العملاء: apps/client_web/build/web"
echo "3️⃣ تطبيق الموردين: apps/supplier_web/build/web"
echo "4️⃣ وحدة التحكم: apps/console_web/build/web"
echo ""

# Netlify deployment suggestions
echo "🌐 اقتراحات النشر على Netlify:"
echo "=================================="
echo ""
echo "للتطبيق الرئيسي:"
echo "netlify deploy --prod --dir build/web"
echo ""
echo "لتطبيق العملاء:"
echo "netlify deploy --prod --dir apps/client_web/build/web --site [client-site-id]"
echo ""
echo "لتطبيق الموردين:"
echo "netlify deploy --prod --dir apps/supplier_web/build/web --site [supplier-site-id]"
echo ""
echo "لوحدة التحكم:"
echo "netlify deploy --prod --dir apps/console_web/build/web --site [console-site-id]"
echo ""

print_warning "تأكد من استبدال [site-id] بمعرف الموقع الفعلي من Netlify"

# File sizes
print_step "أحجام الملفات المبنية:"
echo "التطبيق الرئيسي: $(du -sh build/web 2>/dev/null | cut -f1 || echo 'N/A')"
echo "تطبيق العملاء: $(du -sh apps/client_web/build/web 2>/dev/null | cut -f1 || echo 'N/A')"
echo "تطبيق الموردين: $(du -sh apps/supplier_web/build/web 2>/dev/null | cut -f1 || echo 'N/A')"
echo "وحدة التحكم: $(du -sh apps/console_web/build/web 2>/dev/null | cut -f1 || echo 'N/A')"

echo ""
print_success "✨ جاهز للنشر! راجع دليل النشر في DEPLOYMENT_GUIDE.md للمزيد من التفاصيل"
