import 'package:eco_pulse/Profile_page/add_page.dart';
import 'package:eco_pulse/Profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Define content for each tab
  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0: // Home
        return _buildHomeContent();
      case 1: // Contribute
        return AddDataPage();
      case 2: // Leaderboard
        return _buildLeaderboardContent();
      case 3: // Challenges
        return ProfilePage();
      default:
        return _buildHomeContent();
    }
  }

  // Home Page Content
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            title: 'User Contribution',
            content: 'You’ve actively contributed to making the world a better place!',
            color: Colors.white.withAlpha(40),
            borderColor: Colors.greenAccent,
          ),
          const SizedBox(height: 20),
          _buildContributionCard('Electricity', Icons.lightbulb, Colors.amber),
          const SizedBox(height: 15),
          _buildContributionCard('Food', Icons.restaurant, Colors.orange),
          const SizedBox(height: 15),
          _buildContributionCard('Clothing', Icons.shopping_bag, Colors.purple),
          const SizedBox(height: 15),
          _buildContributionCard('Transport', Icons.subway, Colors.blue),
        ],
      ),
    );
  }

  // Other sections like Contribute, Leaderboard, and Challenges can be customized similarly
  Widget _buildContributeContent() {
    return Center(
      child: Text('Contribute Section'),
    );
  }

  Widget _buildLeaderboardContent() {
    return Center(
      child: Text('Leaderboard Section'),
    );
  }

  Widget _buildChallengesContent() {
    return Center(
      child: Text('Challenges Section'),
    );
  }

  // Info Card
  Widget _buildInfoCard({required String title, required String content, required Color color, required Color borderColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // Contribution Card
  Widget _buildContributionCard(String title, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: iconColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(width: 15),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: '$title: 20 Kg CO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                children: [
                  TextSpan(
                    text: '2',
                    style: TextStyle(
                      fontSize: 14,
                      fontFeatures: [FontFeature.subscripts()],
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Navigation Icon
  Widget _buildNavIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _currentIndex == index ? Colors.white : Colors.white70,
        size: _currentIndex == index ? 30 : 25,
      ),
      onPressed: () => _onItemTapped(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Full-screen gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3c72), Color(0xff2a5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(51),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.eco,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 30,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '0',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content based on selected tab
            Expanded(
              child: _getBodyContent(),
            ),

            // Bottom Navigation Bar
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff30c67c), Color(0xff82f4b1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavIcon(Icons.home, 0),
                  _buildNavIcon(Icons.add_circle, 1),
                  _buildNavIcon(Icons.leaderboard, 2),
                  _buildNavIcon(Icons.task, 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
