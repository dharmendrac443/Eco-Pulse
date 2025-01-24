import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.blue,
              padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.eco,
                    size: 30,
                    color: Colors.amberAccent,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 30,
                        color: Colors.red,
                      ),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Body - Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: SvgPicture.asset(
                  'assets/images/1.svg', // Ensure path is correct
                  width: double.infinity, // Check if size is appropriate
                  height: 300, 
                ),
              ),
            ),
            
            // Sticky Footer with 4 icons
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Home Icon
                  IconButton(
                    icon: Icon(Icons.home, color: Colors.white),
                    onPressed: () => _onItemTapped(0),
                  ),
                  
                  // Contribute Icon
                  IconButton(
                    icon: Icon(Icons.add_circle, color: Colors.white),
                    onPressed: () => _onItemTapped(1),
                  ),
                  
                  // Leaderboard Icon
                  IconButton(
                    icon: Icon(Icons.leaderboard, color: Colors.white),
                    onPressed: () => _onItemTapped(2),
                  ),
                  
                  // Challenges Icon
                  IconButton(
                    icon: Icon(Icons.task, color: Colors.white),
                    onPressed: () => _onItemTapped(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
