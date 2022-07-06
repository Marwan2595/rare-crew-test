import 'package:flutter/material.dart';

import '../components/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: List.generate(10, (index) => const ItemCard()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('TextField in Dialog'),
                    content: Column(
                      children: [
                        TextField(
                          onChanged: (value) {},
                          // controller: _textFieldController,
                          decoration:
                              InputDecoration(hintText: "Text Field in Dialog"),
                        ),
                        TextField(
                          onChanged: (value) {},
                          // controller: _textFieldController,
                          decoration:
                              InputDecoration(hintText: "Text Field in Dialog"),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
