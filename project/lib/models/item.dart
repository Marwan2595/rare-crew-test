class Item {
  int? id;
  String? title;
  String? description;

  Item({this.id, this.title, this.description});

  static Item fromJson(Map<String, Object?> json) => Item(
        id: json[ItemFields.id] as int?,
        title: json[ItemFields.title] as String,
        description: json[ItemFields.description] as String,
      );

  Map<String, Object?> toJson() => {
        ItemFields.id: id,
        ItemFields.title: title,
        ItemFields.description: description,
      };

  Item copy({
    int? id,
    String? title,
    String? description,
  }) =>
      Item(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
}

const String tableItems = 'items';

class ItemFields {
  static final List<String> values = [
    id,
    title,
    description,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
}
