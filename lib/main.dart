import 'package:ecommerce/constants/theme.dart';
import 'package:ecommerce/provider/product_provider.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customTheme(),
      debugShowCheckedModeBanner: false,
      //To give the app a unique theme, we can use the customTheme() function
      //which is defined in the constants/theme.dart file.
      //To give a background color to the app,
      //wrapped the home widget with a container
      home: Container(color: const Color(0xFFF3F4F6), child: const HomePage()),
    );
  }
}
