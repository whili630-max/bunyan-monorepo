import 'package:flutter/material.dart';

void main() {
  // بدون usePathUrlStrategy
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bunyan',
      home: const Scaffold(body: Center(child: Text('Bunyan is running'))),
    );
  }
}
