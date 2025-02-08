import 'package:eco_pulse/Profile_page/profile_page.dart';
import 'package:eco_pulse/home_page/home_page.dart';
import 'package:eco_pulse/login_Page/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  void _checkAuthenticationStatus() async {
    await Firebase.initializeApp();  // Ensure Firebase is initialized
    FirebaseAuth auth = FirebaseAuth.instance;

    // Force sign out to ensure we are checking the correct state
    await auth.signOut();

    // Check if user is logged in after sign-out
    User? user = auth.currentUser;

    // Delay for 3 seconds before navigating
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        // User is logged in, navigate to ProfilePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      } else {
        // No user is logged in, navigate to LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashScreen(),
    );
  }

  Widget _buildSplashScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff82f4b1),
            const Color(0xff30c67c),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _buildSplashScreenContent(),
    );
  }

  Widget _buildSplashScreenContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAppLogo(),
          const SizedBox(height: 20),
          _buildAppName(),
          const SizedBox(height: 10),
          _buildAppTagline(),
        ],
      ),
    );
  }

  Widget _buildAppLogo() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.eco,
        size: 50,
        color: const Color(0xff30c67c),
      ),
    );
  }

  Widget _buildAppName() {
    return Text(
      "EcoPulse",
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAppTagline() {
    return Text(
      "Clean. Green. Future.",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    );
  }
}
