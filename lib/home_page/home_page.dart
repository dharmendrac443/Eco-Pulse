import 'package:eco_pulse/calculate/calculate.dart';
import 'package:eco_pulse/Profile_page/profile_page.dart';
import 'package:eco_pulse/challenges/challenges.dart';
import 'package:flutter/material.dart';
import '../leaderboard/leaderboard.dart';
import '../components/custom_app_bar.dart';
import '../components/navbar.dart';

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

  void _onProfileTap() {
    setState(() {
      _currentIndex = 4; // Switch to the profile tab
    });
  }

  // Define content for each tab
  Widget _getBodyContent() {
    switch (_currentIndex) {
      case 0: // Home
        return _buildHomeContent();
      case 1: // Contribute
        return CalculateScreen();
      case 2: // Leaderboard
        return LeaderboardScreen();
      case 3: // Challenges
        return ChallengesScreen();
      case 4: // Profile
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
            content:
                'You’ve actively contributed to making the world a better place!',
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

  // Info Card
  Widget _buildInfoCard(
      {required String title,
      required String content,
      required Color color,
      required Color borderColor}) {
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
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(onProfileTap: _onProfileTap),
      body: Container(
        // Full-screen gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 70, 151, 12),
              Color.fromARGB(64, 152, 108, 42)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Content based on selected tab
            Expanded(
              child: _getBodyContent(),
            ),

            // Bottom Navigation Bar
            CustomNavBar(
              currentIndex: _currentIndex,
              onItemTapped: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
