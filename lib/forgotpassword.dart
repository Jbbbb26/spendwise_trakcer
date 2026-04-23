// lib/forgotpassword.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added Firebase Auth

class SpendWiseForgotPasswordScreen extends StatefulWidget {
  const SpendWiseForgotPasswordScreen({super.key});

  @override
  State<SpendWiseForgotPasswordScreen> createState() => _SpendWiseForgotPasswordScreenState();
}

class _SpendWiseForgotPasswordScreenState extends State<SpendWiseForgotPasswordScreen> {
  // --- Controllers and Styles ---
  final TextEditingController _emailController = TextEditingController(); // Added Controller
  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF3F4F6);

  @override
  void dispose() {
    _emailController.dispose(); // Clean up controller
    super.dispose();
  }

  // --- Logic to send Reset Link ---
  Future<void> _sendResetEmail() async {
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      _showSnackBar("Please enter your email address.");
      return;
    }

    try {
      // Firebase function that handles the free reset link email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      
      if (mounted) {
        _showSnackBar("Reset link sent! Please check your inbox.");
        // Optional: Return to login since the app's job is done for now
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? "An error occurred. Please try again.");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: primaryDarkGreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 412,
            child: Stack(
              children: [
                Positioned(bottom: 100, left: 0, right: 0, child: _buildBackgroundBars()),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Navigation Row ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text('SpendWise', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: primaryDarkGreen)),
                          const SizedBox(width: 48),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // --- Main Card ---
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reset Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryDarkGreen)),
                            const SizedBox(height: 12),
                            Text('Enter your email to receive a\nreset link', style: TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5)),
                            const SizedBox(height: 32),

                            _buildLabel('EMAIL ADDRESS'),
                            const SizedBox(height: 8),
                            // --- Updated TextField with Controller ---
                            _buildTextField(hintText: 'name@firm.com', controller: _emailController),
                            const SizedBox(height: 32),

                            // --- Updated Button: Send Link instead of OTP ---
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _sendResetEmail, // Call the function
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryDarkGreen,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                                child: const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // --- Back to Log In ---
                            Center(
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back, size: 16, color: Colors.grey.shade700),
                                    const SizedBox(width: 8),
                                    Text('Back to Log In', style: TextStyle(color: Colors.grey.shade700, fontSize: 14, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 180),
                      // ... Footer remains the same ...
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade700, letterSpacing: 0.8));
  }

  Widget _buildTextField({required String hintText, required TextEditingController controller}) {
    return TextFormField(
      controller: controller, // Linked controller here
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: inputBackgroundColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
  
  // ... Keep your _buildBackgroundBars and _bar functions as they were ...
  Widget _buildBackgroundBars() {
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _bar(height: 20, opacity: 0.05),
          _bar(height: 40, opacity: 0.15),
          _bar(height: 25, opacity: 0.08),
          _bar(height: 60, opacity: 0.20),
          _bar(height: 45, opacity: 0.12),
          _bar(height: 80, opacity: 0.25),
          _bar(height: 65, opacity: 0.08),
          _bar(height: 100, opacity: 0.20),
          _bar(height: 50, opacity: 0.10),
          _bar(height: 120, opacity: 0.25),
          _bar(height: 150, opacity: 0.25), 
        ],
      ),
    );
  }

  Widget _bar({required double height, required double opacity}) {
    return Container(width: 28, height: height, color: primaryDarkGreen.withOpacity(opacity));
  }
}