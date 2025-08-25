# بنيان - دليل النشر المتعدد المنصات

## نظرة عامة
يحتوي هذا المشروع على أربع تطبيقات منفصلة:
1. **التطبيق الرئيسي** (`/`) - للعملاء العامين
2. **تطبيق العملاء** (`/apps/client_web`) - لوحة تحكم العملاء
3. **تطبيق الموردين** (`/apps/supplier_web`) - لوحة تحكم الموردين
4. **وحدة التحكم** (`/apps/console_web`) - لوحة التحكم الإدارية

## التصميم الحديث
تم تحديث جميع التطبيقات بتصميم حديث مشابه لتطبيقات توصيل الطعام:
- ألوان متدرجة وجذابة
- تخطيط responsive
- مكونات UI حديثة مع ظلال وحواف مستديرة
- أيقونات Material Design 3
- دعم اللغة العربية والإنجليزية

## استراتيجية النشر

### الخيار 1: مواقع Netlify منفصلة (الموصى به)
نشر كل تطبيق على موقع Netlify منفصل:

#### التطبيق الرئيسي
- **الدومين**: `bunyan.app` (أو النطاق المخصص)
- **مجلد البناء**: `build/web`
- **أمر البناء**: `flutter build web --release`

#### تطبيق العملاء
- **الدومين**: `client.bunyan.app`
- **مجلد البناء**: `apps/client_web/build/web`
- **أمر البناء**: `cd apps/client_web && flutter build web --release`

#### تطبيق الموردين
- **الدومين**: `supplier.bunyan.app`
- **مجلد البناء**: `apps/supplier_web/build/web`
- **أمر البناء**: `cd apps/supplier_web && flutter build web --release`

#### وحدة التحكم
- **الدومين**: `console.bunyan.app`
- **مجلد البناء**: `apps/console_web/build/web`
- **أمر البناء**: `cd apps/console_web && flutter build web --release`

### الخيار 2: موقع واحد مع مسارات فرعية
نشر جميع التطبيقات على موقع واحد مع مسارات فرعية:
- `/` - التطبيق الرئيسي
- `/client` - تطبيق العملاء
- `/supplier` - تطبيق الموردين
- `/console` - وحدة التحكم

## خطوات النشر

### إعداد المواقع المنفصلة

#### 1. إعداد التطبيق الرئيسي
```bash
# إنشاء موقع جديد في Netlify
netlify sites:create --name bunyan-main

# ربط المجلد الحالي
netlify link --id [site-id]

# نشر
netlify deploy --prod --dir build/web
```

#### 2. إعداد تطبيق العملاء
```bash
# إنشاء موقع جديد
netlify sites:create --name bunyan-client

# بناء التطبيق
cd apps/client_web
flutter build web --release

# نشر
netlify deploy --prod --dir build/web --site [client-site-id]
```

#### 3. إعداد تطبيق الموردين
```bash
# إنشاء موقع جديد
netlify sites:create --name bunyan-supplier

# بناء التطبيق
cd apps/supplier_web
flutter build web --release

# نشر
netlify deploy --prod --dir build/web --site [supplier-site-id]
```

#### 4. إعداد وحدة التحكم
```bash
# إنشاء موقع جديد
netlify sites:create --name bunyan-console

# بناء التطبيق
cd apps/console_web
flutter build web --release

# نشر
netlify deploy --prod --dir build/web --site [console-site-id]
```

## ملفات التكوين

### netlify.toml لكل تطبيق
كل تطبيق يحتاج ملف `netlify.toml` منفصل:

#### التطبيق الرئيسي
```toml
[build]
  command = "flutter build web --release"
  publish = "build/web"

[build.environment]
  FLUTTER_WEB = "true"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-XSS-Protection = "1; mode=block"
    X-Content-Type-Options = "nosniff"

[[headers]]
  for = "/assets/*"
  [headers.values]
    Cache-Control = "public, max-age=31536000, immutable"
```

#### تطبيق العملاء
```toml
[build]
  command = "cd apps/client_web && flutter build web --release"
  publish = "apps/client_web/build/web"

[build.environment]
  FLUTTER_WEB = "true"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200
```

## الميزات التقنية

### PWA Support
- ✅ Web App Manifest
- ✅ Service Worker
- ✅ أيقونات PWA (192x192, 512x512)
- ✅ إعدادات الكاش

### SPA Routing
- ✅ PathUrlStrategy (بدون #)
- ✅ ملف _redirects
- ✅ صفحة 404.html
- ✅ onUnknownRoute handler

### التحسينات
- ✅ Tree-shaking للأيقونات
- ✅ ضغط الأصول
- ✅ تحسين الأداء
- ✅ رؤوس الأمان

## اختبار التطبيقات

### اختبار محلي
```bash
# التطبيق الرئيسي
flutter run -d chrome

# تطبيق العملاء
cd apps/client_web && flutter run -d chrome

# تطبيق الموردين
cd apps/supplier_web && flutter run -d chrome

# وحدة التحكم
cd apps/console_web && flutter run -d chrome
```

### اختبار البناء
```bash
# بناء جميع التطبيقات
flutter build web --release
cd apps/client_web && flutter build web --release
cd ../supplier_web && flutter build web --release
cd ../console_web && flutter build web --release
```

## استكشاف الأخطاء

### مشاكل شائعة:
1. **"_flutter is not defined"** - التأكد من flutter_bootstrap.js
2. **أخطاء التوجيه** - التحقق من _redirects و netlify.toml
3. **أخطاء الأيقونات** - التحقق من manifest.json والأيقونات
4. **مشاكل التبعيات** - تشغيل flutter pub get

### سجلات البناء:
```bash
# عرض سجلات Netlify
netlify logs

# عرض سجلات البناء المحلي
flutter build web --verbose
```

## الخطوات التالية

1. ✅ تحديث التصميم لجميع التطبيقات
2. ✅ إعداد التوجيه والتوطين
3. ✅ اختبار البناء المحلي
4. 🚧 إنشاء مواقع Netlify منفصلة
5. 🚧 تكوين النطاقات الفرعية
6. 🚧 نشر جميع التطبيقات
7. 🚧 اختبار الإنتاج

## الملاحظات

- جميع التطبيقات تستخدم نفس المكتبات الأساسية
- التصميم موحد مع ألوان مختلفة لكل منصة:
  - الرئيسي: أخضر (#0D7C66)
  - العملاء: أزرق (#2563EB)
  - الموردين: أخضر فاتح (#10B981)
  - وحدة التحكم: أحمر (#DC2626)
- دعم كامل للعربية مع Directionality.rtl
- جميع التطبيقات جاهزة للنشر والاستخدام
