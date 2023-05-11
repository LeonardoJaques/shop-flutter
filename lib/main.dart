import 'package:flutter/material.dart';
import 'package:shop_flutter/pages/products_overview_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lato',
        primarySwatch: Colors.purple,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
      ),
      home: ProductsOverViewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
