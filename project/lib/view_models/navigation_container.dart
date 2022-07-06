import 'package:flutter/material.dart';
import 'package:rare_crew_test/views/home_view.dart';
import '../components/general.dart';
import '../views/profile_view.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  int navigationIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  List<String> titles = [
    "Home",
    "Profile",
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[navigationIndex]),
          centerTitle: true,
        ),
        body: screens[navigationIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openForm(context);
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
      ),
    );
  }
}
