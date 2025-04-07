import 'package:flutter/material.dart';
import 'pages/login_page.dart'; // Import the LoginPage

void main() {
  runApp(MomsKitchenApp());
}

class MomsKitchenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moms Kitchen',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Start with LoginPage
      debugShowCheckedModeBanner: false,
    );
  }
}
