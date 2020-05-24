import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file:///F:/flutter_demo/ecom_app/lib/screens/product_screen.dart';
import 'file:///F:/flutter_demo/ecom_app/lib/screens/welcome_screen.dart';

//void main() {
//  runApp(MyApp());
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce Flutter Demo',
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ProductPage.id: (context) => ProductPage(),
      },
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: email == null ? WelcomeScreen() : ProductPage(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ProductPage.id: (context) => ProductPage(),
      },
    ),
  );
}
