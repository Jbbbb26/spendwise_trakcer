// lib/forgotpassword.dart
import 'package:flutter/material.dart';
import 'verifyotp.dart';

class SpendWiseForgotPasswordScreen extends StatefulWidget {
  const SpendWiseForgotPasswordScreen({super.key});

  @override
  State<SpendWiseForgotPasswordScreen> createState() => _SpendWiseForgotPasswordScreenState();
}

class _SpendWiseForgotPasswordScreenState extends State<SpendWiseForgotPasswordScreen> {
  // Custom Colors to match the design system
  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF3F4F6);
  final Color textLightGray = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8), 
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 412, // Strict width constraint
            child: Stack(
              children: [
                // --- Background Decorative Bars ---
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: _buildBackgroundBars(),
                ),

                // --- Main Content ---
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Top Navigation Bar ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            color: Colors.black87,
                            onPressed: () {
                              Navigator.pop(context); // Go back to Login
                            },
                          ),
                          Text(
                            'SpendWise',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: primaryDarkGreen,
                              letterSpacing: -0.5,
                            ),
                          ),
                          // Empty box to balance the Row and keep the text perfectly centered
                          const SizedBox(width: 48), 
                        ],
                      ),
                      const SizedBox(height: 32),

                      // --- Main Reset Card ---
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Headers
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: primaryDarkGreen,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Enter your email to receive a\nreset link',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Email Input (Notice no icon in this design)
                            _buildLabel('EMAIL ADDRESS'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              hintText: 'name@firm.com',
                            ),
                            const SizedBox(height: 32),

                            // Send OTP Button
                         // Send OTP Button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigates to the Verify OTP screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SpendWiseVerifyOtpScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryDarkGreen,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6), 
                                  ),
                                ),
                                child: const Text(
                                  'Send OTP',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Back to Log In Link
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context); // Go back to login
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_back, size: 16, color: Colors.grey.shade700),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back to Log In',
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 180), // Push footer to the bottom

                      // --- Footer Section ---
                      Text(
                        '© 2024 ARCHITECTURAL SPENDWISE SYSTEMS\nPRIVACY POLICY        TERMS OF SERVICE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                          height: 1.8,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 20),
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

  // Helper for field labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        letterSpacing: 0.8,
      ),
    );
  }

  // Helper for TextField (No icons for this specific design)
  Widget _buildTextField({required String hintText}) {
    return TextFormField(
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: inputBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Recreates the decorative bar chart in the background
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
          _bar(height: 150, opacity: 0.25), // Cut off by the screen edge
        ],
      ),
    );
  }

  Widget _bar({required double height, required double opacity}) {
    return Container(
      width: 28,
      height: height,
      color: primaryDarkGreen.withOpacity(opacity),
    );
  }
}