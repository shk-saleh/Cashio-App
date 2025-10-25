import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> categories = [
      CategoryItem(icon: Icons.add, label: 'Add', color: const Color(0xFF9CA3AF)),
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

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF3E1), Color(0xFFFFF9F3), Color(0xFFFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.orangeAccent),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Select Category',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for Categories',
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),),
                  ),
                ),
                const SizedBox(height: 24),
                // Categories Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${category.label}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                category.icon,
                                color: category.color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              category.label,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryItem {
  final IconData icon;
  final String label;
  final Color color;

  CategoryItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}
