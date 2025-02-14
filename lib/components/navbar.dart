import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const CustomNavBar({
    required this.currentIndex,
    required this.onItemTapped,
    super.key,
  });

  Widget _buildNavIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.white : Colors.white70,
        size: currentIndex == index ? 30 : 25,
      ),
      onPressed: () => onItemTapped(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 26, 130, 6),
            Color.fromARGB(255, 26, 130, 6),
            // Color.fromARGB(173, 65, 114, 30),
            // Color.fromARGB(218, 41, 41, 41)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.vertical(
              // top: Radius.circular(20),
              ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavIcon(Icons.home, 0),
            _buildNavIcon(Icons.add_circle, 1),
            _buildNavIcon(Icons.leaderboard, 2),
            _buildNavIcon(Icons.task, 3),
          ],
        ),
      ),
    );
  }
}
