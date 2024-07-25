import 'package:flutter/material.dart';
import 'package:sqlite_intro/fetch_products.dart';
import 'package:sqlite_intro/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ProductDataService.getProductsData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
