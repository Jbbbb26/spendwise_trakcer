// lib/budget.dart
import 'package:flutter/material.dart';

class SpendWiseBudgetScreen extends StatefulWidget {
  const SpendWiseBudgetScreen({super.key});

  @override
  State<SpendWiseBudgetScreen> createState() => _SpendWiseBudgetScreenState();
}

class _SpendWiseBudgetScreenState extends State<SpendWiseBudgetScreen> {
  // Custom Colors
  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF4F5F7);
  final Color textLightGray = const Color(0xFF6B7280);
  final Color backgroundGray = const Color(0xFFF4F6F8);
  
  // State for the selected category
  String _selectedCategory = 'Dining';

  // Category Data
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Housing', 'icon': Icons.home_outlined},
    {'name': 'Dining', 'icon': Icons.restaurant_outlined},
    {'name': 'Groceries', 'icon': Icons.shopping_cart_outlined},
    {'name': 'Entertainment', 'icon': Icons.movie_outlined},
    {'name': 'Transport', 'icon': Icons.directions_car_outlined},
    {'name': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 412, // Strict width constraint
            child: Column(
              children: [
                // --- Scrollable Main Content ---
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Top App Bar Area ---
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  'https://i.pravatar.cc/100?img=11'), // Placeholder profile pic
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'SPENDWISE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: primaryDarkGreen,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.settings_outlined, color: primaryDarkGreen, size: 28),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // --- Headers ---
                        Text(
                          'MANAGEMENT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create New Budget',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Define your financial boundaries with\nprecision. A well-structured budget is the\nfirst step toward architectural wealth growth.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- Budget Name Input ---
                        _buildLabel('BUDGET NAME'),
                        const SizedBox(height: 8),
                        _buildTextField(hintText: 'e.g., Summer Vacation'),
                        const SizedBox(height: 24),

                        // --- Category Grid ---
                        _buildLabel('CATEGORY'),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: _categories.map((cat) {
                            final isSelected = _selectedCategory == cat['name'];
                            // Calculate width to fit 2 items per row exactly within the padding
                            final itemWidth = (412 - 48 - 16) / 2; 
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = cat['name'];
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: itemWidth,
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: isSelected ? primaryDarkGreen : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: isSelected 
                                    ? [BoxShadow(color: primaryDarkGreen.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] 
                                    : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      cat['icon'],
                                      color: isSelected ? Colors.white : primaryDarkGreen,
                                      size: 28,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cat['name'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? Colors.white : Colors.grey.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32),

                        // --- Monthly Limit Input ---
                        _buildLabel('MONTHLY LIMIT'),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryDarkGreen),
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            prefixStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryDarkGreen),
                            hintText: '0.00',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            filled: true,
                            fillColor: inputBackgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- Dynamic Recommendation Info Box ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E7EB), // Gray info box background
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.info_outline, color: primaryDarkGreen, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 13, color: Colors.grey.shade800, height: 1.5),
                                    children: [
                                      const TextSpan(text: 'Based on your previous '),
                                      TextSpan(text: _selectedCategory, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: ' trends, we recommend a limit of '),
                                      // Hardcoding a generic limit for the UI, but this can be dynamic later
                                      const TextSpan(text: '\$450.00 ', style: TextStyle(fontWeight: FontWeight.bold)),
                                      const TextSpan(text: 'to maintain your savings goal.'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),

                        // --- Create Budget Button ---
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: () {
                              // Save budget logic
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
                              'Create Budget',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- Discard Draft Button ---
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'DISCARD DRAFT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40), // Padding before bottom nav
                      ],
                    ),
                  ),
                ),

                // --- Custom Bottom Navigation Bar ---
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomNavItem(icon: Icons.grid_view_rounded, label: 'OVERVIEW', isActive: false),
                      _buildBottomNavItem(icon: Icons.receipt_long_rounded, label: 'TRANSACTIONS', isActive: false),
                      _buildBottomNavItem(icon: Icons.account_balance_wallet, label: 'BUDGETS', isActive: true),
                      _buildBottomNavItem(icon: Icons.person_outline, label: 'PROFILE', isActive: false),
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

  // Helper widget for field labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade700,
        letterSpacing: 0.8,
      ),
    );
  }

  // Helper widget for standard text inputs
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

  // Helper widget for custom bottom navigation items
  Widget _buildBottomNavItem({required IconData icon, required String label, required bool isActive}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFE9F0EC) : Colors.transparent, // Light green active bg
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: isActive ? primaryDarkGreen : Colors.grey.shade400,
            size: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: isActive ? primaryDarkGreen : Colors.grey.shade400,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}