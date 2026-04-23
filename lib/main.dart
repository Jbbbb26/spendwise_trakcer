import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added Firebase Auth
import 'package:spendwise_trakcer/login.dart'; 
import 'package:spendwise_trakcer/profile.dart'; 

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F3826)),
        useMaterial3: true,
      ),
      // --- Updated: Using StreamBuilder as the Auth State Listener ---
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. Show a loading spinner while Firebase checks the session
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF0F3826)),
              ),
            );
          }

          // 2. If the snapshot has data, the user is logged in
          if (snapshot.hasData) {
            return const SpendWiseProfileScreen();
          }

          // 3. If no user is found, show the Login screen (image_d23c3d.png)
          return const SpendWiseLoginScreen();
        },
      ),
      
      // Optional: Keep routes if you still need named navigation elsewhere
      routes: {
        '/login': (context) => const SpendWiseLoginScreen(),
        '/profile': (context) => const SpendWiseProfileScreen(),
      },
    );
  }
}