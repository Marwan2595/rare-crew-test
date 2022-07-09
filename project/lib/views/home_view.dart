import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/components/item_card.dart';
import 'package:rare_crew_test/view_models/home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeViewModel homeViewModel = HomeViewModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ref.watch(homeViewModel.homeDataProvider).when(
            data: (items) {
              if (items.isNotEmpty) {
                return ListView(
                  children: items
                      .map((item) => ItemCard(
                            cardItem: item,
                          ))
                      .toList(),
                );
              } else {
                return Center(
                  child: Text(
                    "You Have No Items !",
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                );
              }
            },
            error: (e, s) {
              print("error");
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
