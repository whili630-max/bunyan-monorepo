import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'pages/request_service_page.dart';
import 'pages/supplier_signup_page.dart';
import 'constants.dart';

void main() {
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
  runApp(const BunyanApp());
}

class BunyanApp extends StatelessWidget {
  const BunyanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0D7C66),
        brightness: Brightness.light,
      ),
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: const Color(0xFFF8FFFE),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF2D3748),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Color(0xFF2D3748)),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        color: Colors.white,
      ),
    );
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        title: 'بنيان | BUNYANAPP.COM',
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: theme,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/request': (context) => const RequestServicePage(),
          '/supplier': (context) => const SupplierSignupPage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
            settings: settings,
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF0D7C66),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.home_work, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            const Text(
              'بنيان | BUNYANAPP.COM',
              style: TextStyle(
                color: Color(0xFF2D3748),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/supplier'),
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D7C66).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_add,
                  color: Color(0xFF0D7C66),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D7C66), Color(0xFF0A6B58)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0D7C66).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مرحباً بك في بنيان',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'BUNYANAPP.COM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'منصتك الشاملة لخدمات البناء والتشييد',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _buildStatChip('500+', 'مقاول'),
                            const SizedBox(width: 12),
                            _buildStatChip('1000+', 'مشروع مكتمل'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.engineering,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ابحث عن الخدمة التي تحتاجها...',
                        hintStyle: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.filter_list, color: Color(0xFF94A3B8), size: 20),
                ],
              ),
            ),

            // Categories Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'خدمات البناء والتشييد',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),

            // Services Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: serviceCategories.length + 1,
                itemBuilder: (context, index) {
                  if (index < serviceCategories.length) {
                    final service = serviceCategories[index];
                    return _buildModernServiceCard(
                      context,
                      service,
                      _iconForCategory(service),
                      _colorForCategory(service),
                    );
                  } else {
                    return _buildModernServiceCard(
                      context,
                      'خدمات أخرى',
                      Icons.more_horiz,
                      const Color(0xFF6B7280),
                    );
                  }
                },
              ),
            ),

            // Modern Footer Section
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F2937), Color(0xFF374151)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D7C66),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.engineering, color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BUNYANAPP.COM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            'منصة بنيان الشاملة',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🚀 النسخة 2.0 | أحدث تقنيات البناء',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 200,
        height: 56,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0D7C66), Color(0xFF14B8A6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0D7C66).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/request'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'طلب خدمة جديدة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildStatChip(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildModernServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RequestServicePage(serviceType: title),
            ),
          ),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3748),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForCategory(String category) {
    switch (category) {
      case 'أعمال الحفر':
        return const Color(0xFFEF4444);
      case 'أعمال الخرسانة':
        return const Color(0xFF6B7280);
      case 'أعمال الحديد':
        return const Color(0xFF0EA5E9);
      case 'أعمال الكهرباء':
        return const Color(0xFFF59E0B);
      case 'أعمال السباكة':
        return const Color(0xFF3B82F6);
      case 'أعمال البلاط':
        return const Color(0xFF8B5CF6);
      case 'أعمال الدهان':
        return const Color(0xFF10B981);
      case 'أعمال النجارة':
        return const Color(0xFFF97316);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _iconForCategory(String cat) {
    switch (cat) {
      case 'أعمال الحفر':
        return Icons.agriculture;
      case 'أعمال الخرسانة':
        return Icons.foundation;
      case 'أعمال الحديد':
        return Icons.settings;
      case 'أعمال الكهرباء':
        return Icons.electrical_services;
      case 'أعمال السباكة':
        return Icons.plumbing;
      case 'أعمال البلاط':
        return Icons.grid_view;
      case 'أعمال الدهان':
        return Icons.format_paint;
      case 'أعمال النجارة':
        return Icons.carpenter;
      case 'سباكة':
        return Icons.plumbing;
      case 'كهرباء':
        return Icons.electrical_services;
      case 'أسمنت':
        return Icons.construction;
      case 'بلك':
        return Icons.grid_view;
      case 'مقاول':
        return Icons.engineering;
      case 'مشرف':
        return Icons.supervised_user_circle;
      default:
        return Icons.build;
    }
  }
