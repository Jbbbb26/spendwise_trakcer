// lib/resetpassword.dart
import 'package:flutter/material.dart';

class SpendWiseResetPasswordScreen extends StatefulWidget {
  const SpendWiseResetPasswordScreen({super.key});

  @override
  State<SpendWiseResetPasswordScreen> createState() => _SpendWiseResetPasswordScreenState();
}

class _SpendWiseResetPasswordScreenState extends State<SpendWiseResetPasswordScreen> {
  // State variables for password visibility
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Custom Colors
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
            child: SingleChildScrollView(
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
                          Navigator.pop(context); // Go back to OTP/Forgot Password
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
                      const SizedBox(width: 48), // Spacer to balance the back button
                    ],
                  ),
                  const SizedBox(height: 32),

                  // --- Main Reset Password Card ---
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // --- Headers ---
                        Text(
                          'Create New Password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Your new password must be different\nfrom previous passwords.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- New Password Input ---
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildLabel('NEW PASSWORD'),
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          hintText: '••••••••',
                          isObscured: _obscureNewPassword,
                          onVisibilityToggle: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // --- Confirm New Password Input ---
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildLabel('CONFIRM NEW PASSWORD'),
                        ),
                        const SizedBox(height: 8),
                        _buildPasswordField(
                          hintText: '••••••••',
                          isObscured: _obscureConfirmPassword,
                          onVisibilityToggle: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        const SizedBox(height: 24),

                        // --- Password Requirements Checklist ---
                        Row(
                          children: [
                            _buildChecklistItem(
                              text: '8+ characters',
                              isMet: true, // Hardcoded to true for UI matching
                            ),
                            const SizedBox(width: 32),
                            _buildChecklistItem(
                              text: 'One symbol',
                              isMet: false, // Hardcoded to false for UI matching
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // --- Reset Password Button ---
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // Add reset password logic here
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
                              'Reset Password',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- Secure Protocol Box ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F1F3), // Light gray background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.shield_outlined, // Alternatively: Icons.security
                                color: Colors.grey.shade500,
                                size: 32,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'SECURE VERIFICATION PROTOCOL',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),

                        // --- Bottom Divider ---
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
                              child: Text(
                                'END-TO-END ENCRYPTED',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey.shade400,
                                  letterSpacing: 0.5,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for field labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        letterSpacing: 0.5,
      ),
    );
  }

  // Helper widget specifically for Password Fields
  Widget _buildPasswordField({
    required String hintText,
    required bool isObscured,
    required VoidCallback onVisibilityToggle,
  }) {
    return TextFormField(
      obscureText: isObscured,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        filled: true,
        fillColor: inputBackgroundColor,
        suffixIcon: IconButton(
          icon: Icon(
            isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            color: Colors.grey.shade600,
            size: 20,
          ),
          onPressed: onVisibilityToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }

  // Helper widget for the password checklist items
  Widget _buildChecklistItem({required String text, required bool isMet}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isMet ? primaryDarkGreen : Colors.grey.shade600,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}