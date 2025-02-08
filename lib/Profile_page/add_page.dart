import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_pulse/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final Map<String, TextEditingController> controllers = {
    "Electricity": TextEditingController(),
    "Transport": TextEditingController(),
    "Cloth": TextEditingController(),
    "Food": TextEditingController(),
  };
  bool isLoading = false;

  // Save data to Firestore
  Future<void> saveData() async {
    final DateTime today = DateTime.now();
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Prepare the data for all categories
      Map<String, double> categoryAmounts = {};
      
      for (var category in controllers.keys) {
        String valueText = controllers[category]!.text.trim();
        if (valueText.isNotEmpty) {
          double? amount = double.tryParse(valueText);
          if (amount != null && amount > 0) {
            categoryAmounts[category] = amount;
          }
        }
      }

      if (categoryAmounts.isNotEmpty) {
        // Format today's date as a string (year-month-day)
        String todayString = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

        // Check if data already exists for this user and date (compare by date string)
        var querySnapshot = await FirebaseFirestore.instance
            .collection('userData')
            .where('userId', isEqualTo: user.uid)
            .where('date', isEqualTo: todayString) // Compare by formatted date
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If data exists, update the existing document
          await FirebaseFirestore.instance
              .collection('userData')
              .doc(querySnapshot.docs.first.id) // Get the existing document's ID
              .update({
            ...categoryAmounts, // Update with the new category amounts
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data updated successfully!')),
          );
        } else {
          // If no existing data, create a new document
          await FirebaseFirestore.instance.collection('userData').add({
            'userId': user.uid,
            'date': todayString, // Store the date as a string
            'month': today.month,
            'year': today.year,
            ...categoryAmounts, // Add the categories and amounts
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Data added successfully!')),
          );
        }

        // Clear inputs after saving
        for (var controller in controllers.values) {
          controller.clear();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter values for at least one category.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding data: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter values for the following categories:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...controllers.keys.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: controllers[category],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter value for $category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: saveData,
                      child: Text('Save Data'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: Size(double.infinity, 50),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
