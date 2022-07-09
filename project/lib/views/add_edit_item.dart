import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/models/item.dart';

import '../view_models/home_view_model.dart';
import 'navigation_container.dart';

class AddEditItem extends ConsumerWidget {
  AddEditItem({Key? key, this.item}) : super(key: key);
  final Item? item;
  final HomeViewModel homeViewModel = HomeViewModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleInputController =
        TextEditingController(text: item == null ? "" : item?.title.toString());
    final TextEditingController descriptionInputController =
        TextEditingController(
      text: item == null ? "" : item?.description.toString(),
    );
    String formTitle = item == null ? "Add" : "Edit";
    int itemID = (item == null ? -1 : item?.id)!.toInt();
    return Scaffold(
      appBar: AppBar(
        title: Text("$formTitle Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 120,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: titleInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Item Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Item Title';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    controller: descriptionInputController,
                    // initialValue:
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Item Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Item Description';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(titleInputController.text);
                      if (_formKey.currentState!.validate()) {
                        if (itemID == -1) {
                          Item newItem = Item(
                            title: titleInputController.text,
                            description: descriptionInputController.text,
                          );
                          ref.refresh(homeViewModel.homeAddProvider(newItem));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavigationContainer(index: 0),
                            ),
                          );
                        } else {
                          item?.title = titleInputController.text;
                          item?.description = descriptionInputController.text;
                          ref.refresh(homeViewModel.homeEditProvider(item!));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavigationContainer(index: 0),
                            ),
                          );
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      child: Text(
                        formTitle,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
