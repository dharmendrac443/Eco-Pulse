import 'package:flutter/material.dart';
import '../components/appbar.dart';

class CalculateScreen extends StatelessWidget {
  const CalculateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Center(
        child: Text(
          'This is the Calculate Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
