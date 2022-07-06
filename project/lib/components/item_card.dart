import 'package:flutter/material.dart';

import 'general.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: MediaQuery.of(context).size.width * .8,
        height: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 25,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        openForm(context);
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
            const Text(
              "Description Description Description Description Description Description Description",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
