import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/models/cart.dart';
import 'package:shop_flutter/models/environment.dart';
import 'package:shop_flutter/models/order_list.dart';
import 'package:shop_flutter/models/product_list.dart';
import 'package:shop_flutter/pages/auth_pages.dart';
import 'package:shop_flutter/pages/cart_page.dart';
import 'package:shop_flutter/pages/orders_page.dart';
import 'package:shop_flutter/pages/product_form_page.dart';
import 'package:shop_flutter/pages/products_detail_page.dart';
import 'package:shop_flutter/pages/products_overview_page.dart';
import 'package:shop_flutter/pages/products_page.dart';
import 'package:shop_flutter/utils/app_route.dart';

Future<void> main() async {
  await dotenv.load(fileName: Environment.fileName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter shop',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.deepOrange,
            primary: Colors.purple,
            error: Colors.red,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.AUTH: (context) => const AuthPage(),
          AppRoutes.HOME: (context) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
          AppRoutes.PRODUCTS: (context) => const ProductsPage(),
          AppRoutes.PRODUCTS_FORM: (context) => const ProductFormPage(),
          AppRoutes.CART: (context) => const CartPage(),
          AppRoutes.ORDERS: (context) => const OrdersPage(),
        },
      ),
    );
  }
}
