import 'package:flutter/material.dart';
import 'package:rare_crew_test/view_models/home_view_model.dart';
import 'package:rare_crew_test/views/add_edit_item.dart';
import 'package:rare_crew_test/views/home_view.dart';

import 'profile_view.dart';

class NavigationContainer extends StatefulWidget {
  NavigationContainer({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  HomeViewModel hvm = HomeViewModel();
  int navigationIndex = 0;

  List<Widget> screens = [];
  List<String> titles = [
    "Home",
    "Profile",
  ];
  @override
  void initState() {
    super.initState();
    navigationIndex = widget.index;
    screens = [
      HomeScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[navigationIndex]),
        centerTitle: true,
      ),
      body: screens[navigationIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditItem(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationIndex,
        onTap: (index) {
          setState(() {
            navigationIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
