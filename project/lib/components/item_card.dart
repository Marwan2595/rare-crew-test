import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/models/item.dart';
import 'package:rare_crew_test/view_models/home_view_model.dart';

import '../views/navigation_container.dart';

class ItemCard extends ConsumerWidget {
  ItemCard({Key? key, required this.cardItem}) : super(key: key);
  final Item cardItem;

  HomeViewModel vm = HomeViewModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                Text(
                  cardItem.title.toString(),
                  style: const TextStyle(
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
                        //openForm(context);
                        ref.refresh(vm.homeAddProvider);
                        // updateIndex();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationContainer(index: 0),
                          ),
                        );
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
            Text(
              cardItem.description.toString(),
              style: const TextStyle(
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
