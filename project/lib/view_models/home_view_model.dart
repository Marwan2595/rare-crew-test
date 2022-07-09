import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/models/database.dart';
import 'package:rare_crew_test/models/item.dart';

final homeProvider = Provider<HomeViewModel>((ref) {
  return HomeViewModel();
});

class HomeViewModel {
  ItemsDatabase itemDB = ItemsDatabase.instance;

  //Providers
  final homeDataProvider = FutureProvider.autoDispose<List<Item>>((ref) async {
    final dataProvider = ref.read(homeProvider);
    final items = await dataProvider.getItems();
    return items;
  });
  final homeAddProvider = FutureProvider.family((ref, Item newItem) async {
    final dataProvider = ref.read(homeProvider);
    final item = await dataProvider.addItem(
      title: newItem.title!,
      description: newItem.description!,
    );

    return item;
  });
  final homeEditProvider = FutureProvider.family((ref, Item newItem) async {
    final dataProvider = ref.read(homeProvider);
    await dataProvider.editItem(
      id: newItem.id!,
      title: newItem.title!,
      description: newItem.description!,
    );
  });
  final homeDeleteProvider = FutureProvider.family((ref, int id) async {
    final dataProvider = ref.read(homeProvider);
    await dataProvider.deleteItem(id: id);
  });

  //View Model Functions
  Future getItems() async {
    var items = await itemDB.getAllItems();
    return items;
  }

  Future addItem({required String title, required String description}) async {
    Item newItem = Item(title: title, description: description);
    await itemDB.createItem(newItem);
  }

  Future editItem({
    required int id,
    required String title,
    required String description,
  }) async {
    Item newItem = Item(id: id, title: title, description: description);
    await itemDB.updateItem(newItem);
  }

  Future deleteItem({
    required int id,
  }) async {
    await itemDB.deleteItem(id);
  }
}
