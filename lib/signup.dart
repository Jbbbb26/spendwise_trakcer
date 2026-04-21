// lib/signup.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SpendWiseSignUpScreen extends StatefulWidget {
  const SpendWiseSignUpScreen({super.key});

  @override
  State<SpendWiseSignUpScreen> createState() => _SpendWiseSignUpScreenState();
}

class _SpendWiseSignUpScreenState extends State<SpendWiseSignUpScreen> {
  bool _obscurePassword = true;

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
            width: 412, 
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Centered Logo Section ---
                    Center(
                      child: Text(
                        'SpendWise',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: primaryDarkGreen,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- Headers ---
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: primaryDarkGreen,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Begin your journey into financial clarity.',
                      style: TextStyle(
                        fontSize: 14,
                        color: textLightGray,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Full Name Input ---
                    _buildLabel('FULL NAME'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hintText: 'Name',
                      suffixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 24),

                    // --- Email Input ---
                    _buildLabel('EMAIL ADDRESS'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hintText: 'spendwise@gmail.com',
                      suffixIcon: Icons.alternate_email,
                    ),
                    const SizedBox(height: 24),

                    // --- Password Input ---
                    _buildLabel('SECURE PASSWORD'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hintText: '••••••••••••',
                      suffixIcon: Icons.visibility_outlined,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),

                    // --- Sign Up Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryDarkGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4), 
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // --- Log In Text Link (WITH NAVIGATION) ---
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                color: primaryDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Pops the Sign Up screen off the stack to reveal the Login screen
                                  Navigator.pop(context);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // --- Bottom Divider with Circle ---
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
                        ),
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

  Widget _buildTextField({
    required String hintText,
    required IconData suffixIcon,
    bool isPassword = false,
  }) {
    return TextFormField(
      obscureText: isPassword ? _obscurePassword : false,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: inputBackgroundColor,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.grey.shade400,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : Icon(suffixIcon, color: Colors.grey.shade400, size: 22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}