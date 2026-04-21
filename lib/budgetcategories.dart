// lib/categories.dart
import 'package:flutter/material.dart';

class SpendWiseCategoriesScreen extends StatefulWidget {
  const SpendWiseCategoriesScreen({super.key});

  @override
  State<SpendWiseCategoriesScreen> createState() => _SpendWiseCategoriesScreenState();
}

class _SpendWiseCategoriesScreenState extends State<SpendWiseCategoriesScreen> {
  // Custom Colors
  final Color primaryDarkGreen = const Color(0xFF0F3826);
  final Color inputBackgroundColor = const Color(0xFFF4F5F7);
  final Color backgroundGray = const Color(0xFFF4F6F8);
  final Color lightGreenAccent = const Color(0xFFE9F0EC); // For selected icon background

  // State for the selected category (Setting default to match the image)
  String _selectedCategory = 'Home Improvement';

  // Category Data
  final List<Map<String, dynamic>> _categories = [
    {'title': 'Health', 'subtitle': 'MEDICAL & WELLNESS', 'icon': Icons.health_and_safety_outlined},
    {'title': 'Education', 'subtitle': 'LEARNING & GROWTH', 'icon': Icons.school_outlined},
    {'title': 'Gifts', 'subtitle': 'GIVING & EVENTS', 'icon': Icons.card_giftcard_outlined},
    {'title': 'Travel', 'subtitle': 'ADVENTURE & TRIPS', 'icon': Icons.flight_takeoff_outlined},
    {'title': 'Fitness', 'subtitle': 'SPORT & HEALTH', 'icon': Icons.fitness_center_outlined},
    {'title': 'Home Improvement', 'subtitle': 'RENOVATION & DECOR', 'icon': Icons.home_repair_service_outlined},
    {'title': 'Personal Care', 'subtitle': 'BEAUTY & GROOMING', 'icon': Icons.face_retouching_natural_outlined},
    {'title': 'Subscriptions', 'subtitle': 'DIGITAL SERVICES', 'icon': Icons.event_repeat_outlined},
    {'title': 'Pets', 'subtitle': 'FOOD & VET', 'icon': Icons.pets_outlined},
    {'title': 'Charity', 'subtitle': 'DONATIONS & HELP', 'icon': Icons.volunteer_activism_outlined},
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
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.black87,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'SpendWise',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: primaryDarkGreen,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.help_outline, color: Colors.grey.shade700, size: 22),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // --- Headers ---
                        Text(
                          'CATEGORY SELECTION',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'All Categories',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Refine your budget tracking by selecting a\nspecific category for your expenses.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- Search Bar ---
                        TextField(
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            hintText: 'Search categories (e.g. Travel, Fitness)',
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                            prefixIcon: Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                            filled: true,
                            fillColor: inputBackgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- Category Grid ---
                        GridView.builder(
                          shrinkWrap: true, // Needed inside SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(), 
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75, // Adjusts the height of the cards relative to width
                          ),
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            final isSelected = _selectedCategory == cat['title'];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = cat['title'];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: isSelected 
                                      ? Border.all(color: primaryDarkGreen.withOpacity(0.5), width: 1.5)
                                      : Border.all(color: Colors.transparent, width: 1.5),
                                  boxShadow: [
                                    if (!isSelected) // Subtle shadow only for unselected cards
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.02),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Icon Box
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected ? lightGreenAccent : Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(
                                        cat['icon'],
                                        color: primaryDarkGreen,
                                        size: 40,
                                      ),
                                    ),
                                    const Spacer(),
                                    // Title
                                    Text(
                                      cat['title'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryDarkGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Subtitle
                                    Text(
                                      cat['subtitle'],
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade500,
                                        letterSpacing: 0.8,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // --- Action Buttons (Cancel / Select) ---
                Container(
                  color: backgroundGray,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Discard selection
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              foregroundColor: Colors.black87,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              // Pass the selected category back to the previous screen
                              Navigator.pop(context, _selectedCategory);
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
                              'Select',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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

  // Helper widget for custom bottom navigation items
  Widget _buildBottomNavItem({required IconData icon, required String label, required bool isActive}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? lightGreenAccent : Colors.transparent,
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