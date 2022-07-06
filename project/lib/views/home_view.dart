import 'package:flutter/material.dart';

import '../components/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: List.generate(10, (index) => const ItemCard()),
      ),
    );
  }
}
