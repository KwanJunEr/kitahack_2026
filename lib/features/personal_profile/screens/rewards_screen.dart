import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Example quantities for Garden Materials
  int organicSoilQty = 1;
  int heirloomSeedsQty = 1;

  // User points
  int userPoints = 400;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      // allow automatic resize when keyboard/snack bars appear
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.teal),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'My Rewards',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.teal),
                    onPressed: () {
                      // Show info dialog or screen
                    },
                  ),
                ],
              ),
            ),

            // Current balance card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B9AAA), Color(0xFF00C49A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CURRENT BALANCE',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$userPoints pts',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'FUTURAGROW MEMBER\n120 pts to next rank',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to points history
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Points History'),
                    ),
                  ],
                ),
              ),
            ),

            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.teal,
              tabs: const [
                Tab(text: 'Digital Perks'),
                Tab(text: 'Garden Materials'),
              ],
            ),

            // Flexible Tab views to prevent overflow
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Digital Perks
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _rewardCard('Leaf Master Badge',
                            'Unlock a unique profile hair', 150),
                        _rewardCard('Eco-Warrior Frame',
                            'Animated border for your avatar', 250),
                        _rewardCard('Exclusive Emojis',
                            'Set of 5 organic farming stickers', 80),
                      ],
                    ),
                  ),

                  // Garden Materials
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _gardenMaterialCard(
                          'Organic Soil (2kg)',
                          200,
                          quantity: organicSoilQty,
                          onQuantityChanged: (val) {
                            setState(() {
                              organicSoilQty = val;
                            });
                          },
                        ),
                        _gardenMaterialCard(
                          'Heirloom Seeds',
                          120,
                          quantity: heirloomSeedsQty,
                          onQuantityChanged: (val) {
                            setState(() {
                              heirloomSeedsQty = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rewardCard(String title, String subtitle, int points) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.star, color: Colors.teal),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$points pts', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            ElevatedButton(
              onPressed: () {
                _showPurchaseDialog(title, points, 1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade100,
                foregroundColor: Colors.teal.shade900,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Redeem', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gardenMaterialCard(
    String title,
    int points, {
    required int quantity,
    required Function(int) onQuantityChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.spa, color: Colors.teal, size: 48),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$points pts',
                    style:
                        const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.teal),
                      onPressed: () {
                        if (quantity > 1) onQuantityChanged(quantity - 1);
                      },
                    ),
                    Text(quantity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.teal),
                      onPressed: () {
                        onQuantityChanged(quantity + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _showPurchaseDialog(title, points, quantity);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Purchase'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseDialog(String itemName, int points, int quantity) {
    int totalPoints = points * quantity;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Purchase'),
          content: Text(
            'Do you want to spend $totalPoints pts to purchase $quantity x $itemName?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (userPoints >= totalPoints) {
                  setState(() {
                    userPoints -= totalPoints;
                  });

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You purchased $quantity x $itemName!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Not enough points!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}