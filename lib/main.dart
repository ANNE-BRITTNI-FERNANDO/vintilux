import 'package:flutter/material.dart';
import 'package:vintilux/pages/welcome_page.dart';
import 'package:vintilux/pages/home_page.dart';
import 'package:vintilux/pages/product_page.dart';
import 'package:vintilux/pages/cart_page.dart'; 
// import 'package:vintilux/pages/wishlist_page.dart'; 
import 'package:vintilux/pages/profile_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vintilux',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(), // Welcome page route
        '/home': (context) => HomePage(), // Home page route
        '/products': (context) => const ProductPage(), // Product page route
        '/cart': (context) => CartPage(), // Cart page route
        // '/wishlist': (context) => const WishlistPage(), // Wishlist page route
        '/profile': (context) => ProfilePage(), // Profile page route
      },
      debugShowCheckedModeBanner: false, // Optionally hide debug banner
    );
  }
}
