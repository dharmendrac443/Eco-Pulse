import 'package:eco_pulse/leaderboard/components/userCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  // Sample leaderboard data
  final List<Map<String, dynamic>> leaderboard = [
    {'rank': 1, 'name': 'Alice', 'countrycode': 'ind', 'score': 150},
    {'rank': 2, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 3, 'name': 'Charlie', 'countrycode': 'us', 'score': 120},
    {'rank': 4, 'name': 'Diana', 'countrycode': 'fr', 'score': 110},
    {'rank': 5, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 6, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 7, 'name': 'don', 'countrycode': 'jpn', 'score': 100},
    {'rank': 8, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 9, 'name': 'Evje', 'countrycode': 'jpn', 'score': 100},
    {'rank': 10, 'name': 'Evne', 'countrycode': 'jpn', 'score': 100},
    {'rank': 11, 'name': 'Eyve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 12, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 13, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 14, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 15, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 16, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 17, 'name': 'Eve', 'countrycode': 'jpn', 'score': 100},
    {'rank': 18, 'name': 'nagesh', 'countrycode': 'jpn', 'score': 100},
    {'rank': 19, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 20, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 21, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 22, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 23, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    {'rank': 24, 'name': 'Bob', 'countrycode': 'gb', 'score': 130},
    // Add more users as needed
  ];
  final Map<String, dynamic> _currentPlayer = {
    'rank': 18,
    'name': 'nagesh',
    'countrycode': 'jpn',
    'score': 100
  };
  final String _currentUser = "nagesh";
  int _displayedUsers = 10;
  final ScrollController _scrollController = ScrollController();
  bool _isUserVisible = false;

  void _loadMoreUsers() {
    setState(() {
      print('$_displayedUsers');
      if (_displayedUsers <= leaderboard.length) {
        _displayedUsers += 10;
      }
      // _displayedUsers -= (_displayedUsers + 2) % 10;
    });
  }

  void _reduceUsers() {
    setState(() {
      if (_displayedUsers > 10) {
        _displayedUsers -= 10;
      }

      // _displayedUsers += (_displayedUsers + 2) % 10;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkUserVisibility);
  }

  void _checkUserVisibility() {
    final userIndex =
        leaderboard.indexWhere((user) => user['name'] == _currentUser);
    if (userIndex != -1) {
      final userPosition = _scrollController.position;
      final userOffset = userIndex * 100.0; // Approximate height of each item
      final isVisible = userOffset >= userPosition.pixels &&
          userOffset <= userPosition.pixels + userPosition.viewportDimension;
      setState(() {
        _isUserVisible = isVisible;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_checkUserVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 250,
            child: SvgPicture.asset(
              'assets/images/1.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Positioned(
          //   top: 26,
          //   left: 16,
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.arrow_back,
          //       color: Colors.white,
          //       size: 40,
          //       weight: 100,
          //       shadows: [
          //         BoxShadow(
          //           color: Colors.black45,
          //           offset: Offset(0, 2),
          //           blurRadius: 10,
          //         ),
          //       ],
          //     ),
          //     onPressed: () {
          //       // Navigator.pop(context);
          //       prin
          //     },
          //   ),
          // ),
          Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                height: 250, // Set a fixed height for the container
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 28.0),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'LeaderBoard',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 3,
                      left: 15,
                      right: 0,
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(
                              50.0), // Adjust the width as needed
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(
                              50.0), // Adjust the width as needed
                        },
                        children: const [
                          TableRow(
                            children: [
                              Text('Rank',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('Score',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Leaderboard list
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 50.0,
                      top: 8.0), // Remove any default padding
                  itemCount: _displayedUsers +
                      2, // +2 to include the visibility widget
                  itemBuilder: (context, index) {
                    final userIndex = leaderboard
                        .indexWhere((user) => user['name'] == _currentUser);

                    if (userIndex == -1 ||
                        (userIndex >= _displayedUsers &&
                            index == _displayedUsers)) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 8.0),
                        child: Visibility(
                          visible: !_isUserVisible,
                          child: userCard(_currentPlayer, true),
                        ),
                      );
                    }
                    if (index == _displayedUsers + 1) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _loadMoreUsers,
                            child: Text('View More'),
                          ),
                          if (_displayedUsers > 10)
                            ElevatedButton(
                              onPressed: _reduceUsers,
                              child: Text('View Less'),
                            ),
                        ],
                      );
                    }
                    if (index >= leaderboard.length) return Container();
                    final player = leaderboard[index];
                    final isCurrentUser = player['name'] == _currentUser;
                    if (_isUserVisible && isCurrentUser) {
                      return Container(); // Skip loading the current user card if visible
                    }
                    return userCard(player, isCurrentUser);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
