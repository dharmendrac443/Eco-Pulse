import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildChallengeSection('Daily Challenge', Colors.orange),
              SizedBox(height: 20),
              _buildChallengeSection('Weekly Challenge', Colors.blue),
              SizedBox(height: 20),
              _buildChallengeSection('Monthly Challenge', Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeSection(String title, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 10),
            _buildChallengeCard(
                'Challenge 1', 'Description of challenge 1', color),
            SizedBox(height: 10),
            _buildChallengeCard(
                'Challenge 2', 'Description of challenge 2', color),
            SizedBox(height: 10),
            _buildChallengeCard(
                'Challenge 3', 'Description of challenge 3', color),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard(String title, String description, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: ListTile(
        leading: Icon(Icons.check_circle, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle challenge completion
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          child: Text('Complete'),
        ),
      ),
    );
  }
}
