import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateState();
}

class _CalculateState extends State<CalculateScreen> {
  final Map<String, TextEditingController> controllers = {
    "LastMonthElectricity": TextEditingController(),
    "ThisMonthElectricity": TextEditingController(),
    "Electricity": TextEditingController(),
    "Transport": TextEditingController(),
    "Food": TextEditingController(),
    "Water": TextEditingController(),
  };
  bool isLoading = false;
  String? selectedCategory = 'Electricity'; // Default selected category
  String? selectedUsedTransport;
  String? selectedInsteadOfTransport;
  bool showAdditionalDetails = false;

  // Vehicle hierarchy
  final List<String> vehicleHierarchy = [
    'Walk',
    'Cycle',
    'Bike',
    'Car',
    'Truck',
    'Aeroplane',
  ];

  // Vehicle icons
  final Map<String, IconData> vehicleIcons = {
    'Walk': Icons.directions_walk,
    'Cycle': Icons.directions_bike,
    'Bike': Icons.motorcycle,
    'Car': Icons.directions_car,
    'Truck': Icons.local_shipping,
    'Aeroplane': Icons.flight,
  };

  // Conversion factors
  final Map<String, double> transportEmissionFactors = {
    'Walk': 0.0,
    'Cycle': 0.0,
    'Bike': 0.1,
    'Car': 0.2,
    'Truck': 0.5,
    'Aeroplane': 0.3,
  };

  // Save data to Firestore
  Future<void> saveData() async {
    final DateTime today = DateTime.now();
    final User? user = FirebaseAuth.instance.currentUser;
    await _updateStreak();
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

      // Calculate carbon footprint
      double totalCarbonFootprint = 0.0;
      if (categoryAmounts.containsKey('LastMonthElectricity') &&
          categoryAmounts.containsKey('ThisMonthElectricity')) {
        double lastMonthElectricity = categoryAmounts['LastMonthElectricity']!;
        double thisMonthElectricity = categoryAmounts['ThisMonthElectricity']!;
        double electricityDifference =
            thisMonthElectricity - lastMonthElectricity;
        categoryAmounts['Electricity'] = electricityDifference;
        totalCarbonFootprint += electricityDifference * 0.92; // kg CO2 per kWh
      }
      if (categoryAmounts.containsKey('Transport') &&
          selectedUsedTransport != null &&
          selectedInsteadOfTransport != null) {
        double usedTransportEmission = categoryAmounts['Transport']! *
            transportEmissionFactors[selectedUsedTransport]!;
        double insteadOfTransportEmission = categoryAmounts['Transport']! *
            transportEmissionFactors[selectedInsteadOfTransport]!;
        totalCarbonFootprint +=
            insteadOfTransportEmission - usedTransportEmission;
      }
      if (categoryAmounts.containsKey('Food')) {
        totalCarbonFootprint +=
            categoryAmounts['Food']! * 2.5; // kg CO2 per kg of food
      }
      if (categoryAmounts.containsKey('Water')) {
        totalCarbonFootprint +=
            categoryAmounts['Water']! * 0.001; // kg CO2 per liter
      }

      if (categoryAmounts.isNotEmpty) {
        // Format today's date as a string (year-month-day)
        String todayString =
            "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

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
              .doc(
                  querySnapshot.docs.first.id) // Get the existing document's ID
              .update({
            ...categoryAmounts, // Update with the new category amounts
            'carbonFootprint': totalCarbonFootprint,
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
            // 'carbonFootprint': totalCarbonFootprint,
            // 'currentStreak': 1,
            // 'maxStreak': 1, // Initialize streaks
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
          SnackBar(
              content: Text('Please enter values for at least one category.')),
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

  Future<void> _updateStreak() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc =
        FirebaseFirestore.instance.collection('streak').doc(user.uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      if (!snapshot.exists) {
        // First entry for the user
        transaction.set(userDoc, {
          'currentStreak': 1,
          'maxStreak': 1,
          'lastLogin': Timestamp.fromDate(today),
        });
        return;
      }

      Map<String, dynamic> data = snapshot.data()!;
      int currentStreak = data['currentStreak'] ?? 0;
      int maxStreak = data['maxStreak'] ?? 0;
      DateTime lastLogin =
          (data['lastLogin'] as Timestamp?)?.toDate() ?? DateTime(2000);
      DateTime lastLoginDate =
          DateTime(lastLogin.year, lastLogin.month, lastLogin.day);

      if (lastLoginDate == today.subtract(const Duration(days: 1))) {
        // Consecutive day: Increment streak
        currentStreak += 1;
      } else if (lastLoginDate
          .isBefore(today.subtract(const Duration(days: 1)))) {
        // Missed a day: Reset streak
        currentStreak = 1;
      }

      // Update max streak if needed
      maxStreak = currentStreak > maxStreak ? currentStreak : maxStreak;

      transaction.update(userDoc, {
        'currentStreak': currentStreak,
        'maxStreak': maxStreak,
        'lastLogin': Timestamp.fromDate(today),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calculate your carbon footprint',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildCategoryBox(
                      'Electricity',
                      Icon(Icons.electrical_services,
                          size: 30, color: Colors.white)),
                  _buildCategoryBox(
                      'Transport',
                      Icon(Icons.directions_car,
                          size: 30, color: Colors.white)),
                  _buildCategoryBox('Water',
                      Icon(Icons.water, size: 30, color: Colors.white)),
                  _buildCategoryBox('Food',
                      Icon(Icons.fastfood, size: 30, color: Colors.white)),
                ],
              ),
              SizedBox(height: 26),
              if (selectedCategory != null) ...[
                if (selectedCategory == 'Electricity') ...[
                  _buildElectricityOptions(),
                ] else if (selectedCategory == 'Transport') ...[
                  _buildTransportOptions(),
                ] else if (selectedCategory == 'Water') ...[
                  _buildWaterOptions(),
                ] else if (selectedCategory == 'Food') ...[
                  _buildFoodOptions(),
                ],
                SizedBox(height: 26),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showAdditionalDetails = !showAdditionalDetails;
                    });
                  },
                  child: Text('Add more details'),
                ),
                if (showAdditionalDetails)
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: TextField(
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter additional details',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                SizedBox(height: 16),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: saveData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          iconColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Calculate',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBox(String category, Icon icon) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
          selectedUsedTransport = null;
          selectedInsteadOfTransport = null;
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? Colors.teal
              : Colors.black, // Highlight selected category
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: 8),
              Text(
                category,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElectricityOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controllers['LastMonthElectricity'],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: 'kWh',
            hintText: 'Enter last month Units',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: controllers['ThisMonthElectricity'],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: 'kWh',
            hintText: 'Enter this month Units',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildTransportOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Select Used Transport',
            border: OutlineInputBorder(),
          ),
          value: selectedUsedTransport,
          onChanged: (String? newValue) {
            setState(() {
              selectedUsedTransport = newValue;
              selectedInsteadOfTransport = null; // Reset instead of transport
            });
          },
          items: vehicleHierarchy.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Icon(vehicleIcons[value], size: 24),
                  SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        if (selectedUsedTransport != null)
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Instead Of Transport',
              border: OutlineInputBorder(),
            ),
            value: selectedInsteadOfTransport,
            onChanged: (String? newValue) {
              setState(() {
                selectedInsteadOfTransport = newValue;
              });
            },
            items: vehicleHierarchy
                .where((vehicle) =>
                    vehicleHierarchy.indexOf(vehicle) >
                    vehicleHierarchy.indexOf(selectedUsedTransport!))
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Row(
                  children: [
                    Icon(vehicleIcons[value], size: 24),
                    SizedBox(width: 8),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: controllers['Transport'],
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: 'Km',
            hintText: 'Enter kilometers traveled',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildWaterOptions() {
    return TextField(
      controller: controllers['Water'],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText: 'L',
        hintText: 'Enter how much water saved',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildFoodOptions() {
    return TextField(
      controller: controllers['Food'],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        suffixText: 'Kg',
        hintText: 'Enter how much food saved',
        border: OutlineInputBorder(),
      ),
    );
  }
}
