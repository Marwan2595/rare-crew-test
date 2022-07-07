import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/models/database.dart';
import 'package:rare_crew_test/models/item.dart';

final homeProvider = Provider<HomeViewModel>((ref) {
  return HomeViewModel();
});

class HomeViewModel {
  ItemsDatabase itemDB = ItemsDatabase.instance;

  final homeDataProvider = FutureProvider.autoDispose<List<Item>>((ref) async {
    final dataProvider = ref.read(homeProvider);
    final items = await dataProvider.getItems();
    return items;
  });
  final homeAddProvider = FutureProvider.autoDispose<Item>((ref) async {
    final dataProvider = ref.read(homeProvider);
    final item = await dataProvider.addItem(
      title: "666666666666",
      description: "66666666666666",
    );

    return item;
  });

  Future getItems() async {
    var items = await itemDB.getAllItems();
    return items;
  }

  Future addItem({required String title, required String description}) async {
    Item newItem = Item(title: title, description: description);
    await itemDB.createItem(newItem);
  }
}
