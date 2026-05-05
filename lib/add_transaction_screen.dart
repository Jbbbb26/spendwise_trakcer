import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SpendWiseAddTransactionScreen extends StatefulWidget {
  const SpendWiseAddTransactionScreen({super.key});

  @override
  State<SpendWiseAddTransactionScreen> createState() => _SpendWiseAddTransactionScreenState();
}

class _SpendWiseAddTransactionScreenState extends State<SpendWiseAddTransactionScreen> {
  final Color primaryGreen = const Color(0xFF0F3826);
  final Color backgroundGray = const Color(0xFFF8F9FA);

  // --- STATE VARIABLES ---
  // Tracks whether the user is adding an income or expense
  String _activeTab = 'Expenses'; 
  
  // Stores the amount as a string from the calculator taps
  String _amount = "0";

  // --- DATABASE SAVING LOGIC ---
  Future<void> _saveTransaction() async {
    final user = FirebaseAuth.instance.currentUser;
if (user == null || double.parse(_amount) == 0.0) return;

    // Show a quick loading spinner
    showDialog(context: context, barrierDismissible: false, builder: (context) => const Center(child: CircularProgressIndicator()));

    // 1. Convert variables to correct database formats
    final double finalAmount = double.parse(_amount);
    final isExpense = _activeTab == 'Expenses';
    
    // We'll use a static category for now, just like your image. 
    // We can make this dynamic later.
    const String category = 'Dining & Cafe';
    const int iconCode = 0xe530; // 'restaurant' icon

    final transactionsRef = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('transactions');
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    // --- TRANSACTION LOGIC: Update two things at once ---
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // A. Add the new transaction record
        transaction.set(transactionsRef.doc(), {
          'type': isExpense ? 'expense' : 'income',
          'amount': finalAmount,
          'category': category,
          'category_icon_code': iconCode,
          'timestamp': FieldValue.serverTimestamp(), // Current server time
        });

        // B. Update the main user document (balance, income/spent totals)
        final userSnapshot = await transaction.get(userDocRef);
        final userData = userSnapshot.data() as Map<String, dynamic>;
        
        final double currentBalance = (userData['balance'] as num).toDouble();
        final double currentIncome = (userData['monthly_income'] as num).toDouble();
        final double currentSpent = (userData['monthly_spent'] as num).toDouble();

        double newBalance = currentBalance;
        double newIncomeTotal = currentIncome;
        double newSpentTotal = currentSpent;

        if (isExpense) {
          // If expense: Decrease balance, increase monthly spent
          newBalance -= finalAmount;
          newSpentTotal += finalAmount;
        } else {
          // If income: Increase balance, increase monthly income
          newBalance += finalAmount;
          newIncomeTotal += finalAmount;
        }

        // Apply these updates together
        transaction.update(userDocRef, {
          'balance': newBalance,
          'monthly_income': newIncomeTotal,
          'monthly_spent': newSpentTotal,
        });
      });

      // Navigate back to the overview/dashboard
      if (mounted) {
        Navigator.pop(context); // Close loading spinner
        Navigator.pop(context); // Close add screen
      }

    } catch (e) {
      if (mounted) Navigator.pop(context); // Close loading spinner
      debugPrint("Save Transaction Error: $e");
    }
  }

  // --- CALCULATOR HELPER FUNCTIONS ---
  void _onKeyPress(String key) {
    setState(() {
      if (_amount == "0") {
        if (key == ".") {
          _amount = "0.";
        } else {
          _amount = key; // replaces '0' with the first digit
        }
      } else {
        _amount += key;
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_amount.length > 1) {
        _amount = _amount.substring(0, _amount.length - 1);
      } else {
        _amount = "0"; // resetting to '0' on last digit
      }
    });
  }

  // Formatting helper for currency display
  String _formatCurrency(String amountStr) {
    if (amountStr == '0' || amountStr.isEmpty) return '0.00';
    try {
      final double amount = double.parse(amountStr);
      return amount.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentTime = DateFormat('jm').format(DateTime.now());

    return Scaffold(
      backgroundColor: backgroundGray,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  // --- Main App Bar from design ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage: const AssetImage('assets/images/profile.png'), 
                              backgroundColor: Colors.blueGrey.shade200,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('SPENDWISE', style: TextStyle(fontWeight: FontWeight.w900, color: primaryGreen, fontSize: 16)),
                        ],
                      ),
                      const Icon(Icons.settings_outlined),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Income/Expenses Tabs ---
                  Container(
                    decoration: BoxDecoration(color: const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        _buildTab('Income'),
                        _buildTab('Expenses'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // --- Amount to Log ---
                  const Text('AMOUNT TO LOG', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('\$', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
                      const SizedBox(width: 8),
                      // This Text widget display is dynamic and linked to our _amount state variable
                      Text(
                        _formatCurrency(_amount), 
                        style: const TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Color(0xFF161E2E)),
                      ),
                      const SizedBox(width: 16),
                      // Backspace button
                      GestureDetector(
                        onTap: _onBackspace,
                        child: Icon(Icons.backspace_outlined, size: 24, color: Colors.grey.shade400),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),

                  // --- Static Category Card from your design ---
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: const Color(0xFFC8F6E0), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.restaurant, color: Color(0xFF0F3826), size: 20),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Dining & Cafe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text('Today at $currentTime', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(12)),
                          child: const Text('EXPENSE', style: TextStyle(color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(), // Pushes the keypad to the bottom

            // --- Custom Calculator Keypad using GridView ---
            _buildKeypad(),

            const SizedBox(height: 16),

            // --- Add Transaction Button ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveTransaction, // LINK TO OUR SAVE FUNCTION
                  icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 16),
                  label: const Text('Add Transaction'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tab builder helper
  Widget _buildTab(String title) {
    bool isActive = _activeTab == title;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTab = title;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // Custom keypad builder
  Widget _buildKeypad() {
    final keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '.', '0'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      child: GridView.builder(
        shrinkWrap: true, // prevents grid from scrolling
        physics: const NeverScrollableScrollPhysics(), // grid is static
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // three columns
          crossAxisSpacing: 30, // design spacing
          mainAxisSpacing: 30, // design spacing
          childAspectRatio: 1.0, // perfect circles
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF8F9FA), // subtle button color from design
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _onKeyPress(key),
                borderRadius: BorderRadius.circular(50),
                child: Center(
                  child: Text(
                    key,
                    style: const TextStyle(fontSize: 28, color: Color(0xFF1F2937), fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}