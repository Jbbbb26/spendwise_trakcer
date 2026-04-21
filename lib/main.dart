import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// 1. ADD THIS IMPORT (Make sure the filename matches yours exactly)
import 'package:spendwise_trakcer/login.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SpendWiseApp());
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpendWise',
      debugShowCheckedModeBanner: false, // Optional: removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // 2. CHANGE THIS LINE to your Login Screen class name
      home: const SpendWiseLoginScreen(), 
    );
  }
}