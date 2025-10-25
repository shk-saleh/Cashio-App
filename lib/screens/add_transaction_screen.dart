import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:cashio/models/transaction.dart';

// Category Model
class CategoryItem {
  final String label;
  final IconData icon;
  final Color color;

  CategoryItem({
    required this.label,
    required this.icon,
    required this.color,
  });
}

// Sample categories
final List<CategoryItem> categories = [
  CategoryItem(icon: Icons.shopping_bag, label: 'Groceries', color: const Color(0xFF10B981)),
  CategoryItem(icon: Icons.airplanemode_active, label: 'Travel', color: const Color(0xFF06B6D4)),
  CategoryItem(icon: Icons.directions_car, label: 'Car', color: const Color(0xFF6366F1)),
  CategoryItem(icon: Icons.home, label: 'Home', color: const Color(0xFFD946EF)),
  CategoryItem(icon: Icons.security, label: 'Insurance', color: const Color(0xFF0EA5E9)),
  CategoryItem(icon: Icons.book, label: 'Education', color: const Color(0xFF8B5CF6)),
  CategoryItem(icon: Icons.phone, label: 'Marketing', color: const Color(0xFFFFB84D)),
  CategoryItem(icon: Icons.shopping_cart, label: 'Shopping', color: const Color(0xFF10B981)),
  CategoryItem(icon: Icons.wifi, label: 'Internet', color: const Color(0xFF06B6D4)),
  CategoryItem(icon: Icons.opacity, label: 'Water', color: const Color(0xFF3B82F6)),
  CategoryItem(icon: Icons.build, label: 'Rent', color: const Color(0xFFF97316)),
  CategoryItem(icon: Icons.fitness_center, label: 'Gym', color: const Color(0xFFF97316)),
  CategoryItem(icon: Icons.notifications, label: 'Subscription', color: const Color(0xFFA855F7)),
  CategoryItem(icon: Icons.telegram, label: 'Vacation', color: const Color(0xFF22C55E)),
  CategoryItem(icon: Icons.more_horiz, label: 'Other', color: const Color(0xFF8B5CF6)),
];

// Add Expense Screen
class AddExpenseScreen extends StatefulWidget {
  final Function(Transaction) onAddExpense;

  const AddExpenseScreen({
    super.key,
    required this.onAddExpense,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  CategoryItem? selectedCategory;

  void _submitExpense() {
    final amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    final transaction = Transaction(
      id: const Uuid().v4(),
      category: selectedCategory!.label,
      amount: amount,
      date: DateTime.now(),
      iconCode: selectedCategory!.icon.codePoint,
      colorValue: selectedCategory!.color.value,
    );

    widget.onAddExpense(transaction);

    setState(() {
      _amountController.clear();
      selectedCategory = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added successfully')),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
        child: Column(
          children: [
            // Header
            const Text(
              'Add Expense',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            // Amount Input Field
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  hintText: '0.0',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
              ),
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Enter Amount',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
              ),
            ),
            const SizedBox(height: 80),
            // Categories Horizontal Scroll
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Category',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected =
                          selectedCategory?.label == category.label;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => selectedCategory = category),
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? category.color
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: isSelected
                                ? null
                                : Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: category.color.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                                : null,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                category.icon,
                                color: isSelected
                                    ? Colors.white
                                    : category.color,
                                size: 20,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                category.label,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Add Expense Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Add Expense',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}