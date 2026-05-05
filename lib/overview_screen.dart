import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_transaction_screen.dart';

class SpendWiseOverviewScreen extends StatefulWidget {
  const SpendWiseOverviewScreen({super.key});

  @override
  State<SpendWiseOverviewScreen> createState() => _SpendWiseOverviewScreenState();
}

class _SpendWiseOverviewScreenState extends State<SpendWiseOverviewScreen> {
  final Color primaryGreen = const Color(0xFF0F3826);
  final Color backgroundGray = const Color(0xFFF8F9FA);
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushNamed(context, '/profile');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get the current logged-in user
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: backgroundGray,
      body: SafeArea(
        // 2. Add StreamBuilder to listen to Firestore in real-time
        child: user == null 
          ? const Center(child: Text("Please log in."))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
              builder: (context, snapshot) {
                
                // Show loading spinner while fetching data
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF0F3826)));
                }

                // Safely extract data, providing fallbacks if the database is empty
                final data = snapshot.data?.data() as Map<String, dynamic>?;
                
                // Dynamic Variables from Database (with default fallbacks)
                final double balance = data?['balance']?.toDouble() ?? 0.00;
                final double monthlyIncome = data?['monthly_income']?.toDouble() ?? 0.00;
                final double monthlySpent = data?['monthly_spent']?.toDouble() ?? 0.00;
                final String displayName = data?['first_name'] ?? user.displayName ?? 'User';

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Header ---
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/profile'),
                              child: const CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage('assets/images/profile.png'), 
                                backgroundColor: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'HELLO, ${displayName.toUpperCase()}', // Dynamic Name
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: primaryGreen,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.settings_outlined, size: 28),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // --- Tabs ---
                        Row(
                          children: [
                            _buildTab('Overview', isActive: true),
                            const SizedBox(width: 10),
                            _buildTab('Income', isActive: false),
                            const SizedBox(width: 10),
                            _buildTab('Expenses', isActive: false),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // --- Balance Card ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TOTAL AVAILABLE BALANCE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Dynamic Balance
                              Text(
                                '\$${balance.toStringAsFixed(2)}', 
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC8F6E0),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  '↑ Active Sync',
                                  style: TextStyle(
                                    color: Color(0xFF0C7A43),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Dynamic Income and Spent
                                  Text('INCOME: \$${monthlyIncome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                                  Text('SPENT: \$${monthlySpent.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- Budget Status (Still UI placeholders for now) ---
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Budget Status',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              _buildBudgetBar('Housing', '85% used', 0.85),
                              const SizedBox(height: 16),
                              _buildBudgetBar('Dining', '42% used', 0.42),
                              const SizedBox(height: 16),
                              _buildBudgetBar('Entertainment', '18% used', 0.18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80), 
                      ],
                    ),
                  ),
                );
              }
            ),
      ),
      
      // --- Floating Action Button ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the new add transaction interface
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SpendWiseAddTransactionScreen()),
          );
        },
        backgroundColor: primaryGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      
      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,         
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey.shade400,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'OVERVIEW'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'TRANSACTIONS'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'BUDGETS'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }

  // --- Helper Widgets ---
  Widget _buildTab(String title, {required bool isActive}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: isActive ? null : Border.all(color: Colors.grey.shade300),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade600,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetBar(String title, String subtitle, double percentage) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: Colors.grey.shade300,
          color: primaryGreen,
          minHeight: 6,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}