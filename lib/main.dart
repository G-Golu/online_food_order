import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_food_order/services/auth/auth_gate.dart';
import 'package:online_food_order/services/auth/login_or_register.dart';
import 'package:online_food_order/firebase_options.dart';
import 'package:online_food_order/models/restaurant.dart';
import 'package:online_food_order/pages/register_page.dart';
import 'package:online_food_order/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // here below related firebase after firebase configure successfully
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
        providers:[
          // theme provider
          ChangeNotifierProvider(create: (context) => ThemeProvider()),

          // restaurant provider
          ChangeNotifierProvider(create: (context) => Restaurant()),
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme:Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

