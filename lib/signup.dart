// lib/signup.dart
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SpendWiseSignUpScreen extends StatefulWidget {
  const SpendWiseSignUpScreen({super.key});

  @override
  State<SpendWiseSignUpScreen> createState() => _SpendWiseSignUpScreenState();
}

class _SpendWiseSignUpScreenState extends State<SpendWiseSignUpScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false; // Added loading state for better UX

  // --- Controllers to capture student input ---
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF3F4F6);
  final Color textLightGray = const Color(0xFF6B7280);

  // Clean up controllers when the widget is destroyed
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showError("Please fill in all fields");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Create the user (Firebase logs them in automatically here)
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // 2. Sync the Display Name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());
      await userCredential.user?.reload();

      // 3. MANDATORY: Sign out immediately.
      // This "tricks" the Auth Listener in main.dart so it doesn't 
      // jump to the Dashboard. It stays on the Login UI.
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account Created! Please log in with your credentials.'),
            backgroundColor: Color(0xFF0F3826),
          ),
        );

        // 4. Go back to the Login Screen
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String message = "Registration failed";
        if (e.code == 'weak-password') message = "Password is too weak";
        if (e.code == 'email-already-in-use') message = "Email already exists";
        _showError(message);
      }
    } catch (e) {
      if (mounted) _showError("An unexpected error occurred.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Updated _showError with safety check
  void _showError(String message) {
    if (!mounted) return; // Prevent crashes if screen is closing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), 
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating, // Looks better with modern UI
      ),
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
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
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

                    _buildLabel('FULL NAME'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      suffixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 24),

                    _buildLabel('EMAIL ADDRESS'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'spendwise@gmail.com',
                      suffixIcon: Icons.alternate_email,
                    ),
                    const SizedBox(height: 24),

                    _buildLabel('SECURE PASSWORD'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: '••••••••••••',
                      suffixIcon: Icons.visibility_outlined,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),

                    // --- Updated Sign Up Button ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryDarkGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2))
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Log In',
                              style: TextStyle(
                                color: primaryDarkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // 1. Force a sign out to clear any old session
                                  // This ensures the Auth Listener in main.dart shows the Login UI
                                  await FirebaseAuth.instance.signOut();

                                  // 2. Go back to the previous screen (Login)
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                                color: Colors.grey.shade200, thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1.5),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                                color: Colors.grey.shade200, thickness: 1)),
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
    required TextEditingController controller,
    required String hintText,
    required IconData suffixIcon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
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
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
