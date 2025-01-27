﻿import "package:eco_pulse/login_Page/login_page.dart";
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginPage();
  }

  void _navigateToLoginPage() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
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