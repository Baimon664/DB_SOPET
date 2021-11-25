import 'package:db_sopet/home.dart';
import 'package:db_sopet/payment.dart';
import 'package:db_sopet/service_screen.dart';
import 'package:db_sopet/top_up.dart';
import 'package:db_sopet/user_profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/user' : (context) => const User(),
        '/topup' : (context) => const TopUp(),
        '/payment': (context) => const Payment(),
        '/service': (context) => const ServiceScreen(),
      },
    );
  }
}

