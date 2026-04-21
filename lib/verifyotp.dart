// lib/verifyotp.dart
import 'package:flutter/material.dart';
import 'resetpassword.dart';

class SpendWiseVerifyOtpScreen extends StatefulWidget {
  const SpendWiseVerifyOtpScreen({super.key});

  @override
  State<SpendWiseVerifyOtpScreen> createState() => _SpendWiseVerifyOtpScreenState();
}

class _SpendWiseVerifyOtpScreenState extends State<SpendWiseVerifyOtpScreen> {
  // Custom Colors to match the design system
  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF4F5F7);
  final Color textLightGray = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 412, // Strict width constraint
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center, // Centered for this specific UI
                  children: [
                    const SizedBox(height: 40),

                    // --- Headers ---
                    Text(
                      'Verify OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryDarkGreen,
                        letterSpacing: -1.0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Enter the 6-digit code sent to your\nemail',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- 6-Digit OTP Input Row ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) => _buildOtpBox(context)),
                    ),
                    const SizedBox(height: 40),

                    // --- Verify & Proceed Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                       Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SpendWiseResetPasswordScreen(),
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
                          'Verify & Proceed',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- Resend Code Section ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DIDN'T RECEIVE THE\nCODE?",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.8,
                            height: 1.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Add Resend OTP logic here
                          },
                          child: Text(
                            "RESEND\nCODE",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkGreen,
                              letterSpacing: 0.8,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // --- Divider ---
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    const SizedBox(height: 32),

                    // --- Footer Section ---
                    Text(
                      '© 2024 SPENDWISE FINANCIAL. ALL\nRIGHTS RESERVED.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFooterLink('PRIVACY\nPOLICY'),
                        _buildFooterLink('TERMS OF\nSERVICE'),
                        _buildFooterLink('HELP\nCENTER'),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build individual OTP input boxes
  Widget _buildOtpBox(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryDarkGreen,
        ),
        decoration: InputDecoration(
          counterText: "", // Hides the character counter below the box
          filled: true,
          fillColor: inputBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.zero, // Centers the text vertically
        ),
        onChanged: (value) {
          // Automatically moves focus to the next box when a number is typed
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  // Helper widget for footer links
  Widget _buildFooterLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade500,
        letterSpacing: 0.5,
        height: 1.5,
      ),
    );
  }
}