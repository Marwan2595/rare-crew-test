import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'item.dart';

class ItemsDatabase {
  static final ItemsDatabase instance = ItemsDatabase._init();

  static Database? _database;

  ItemsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('items.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableItems ( 
  ${ItemFields.id} $idType, 
  ${ItemFields.title} $textType,
  ${ItemFields.description} $textType

  )
''');
  }

  Future<Item> createItem(Item item) async {
    final db = await instance.database;
    final id = await db.insert(tableItems, item.toJson());
    return item.copy(id: id);
  }

  Future<Item> getItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableItems,
      columns: ItemFields.values,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Item>> getAllItems() async {
    final db = await instance.database;

    const orderBy = '${ItemFields.id} ASC';

    final result = await db.query(tableItems, orderBy: orderBy);

    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int> updateItem(Item item) async {
    final db = await instance.database;

    return db.update(
      tableItems,
      item.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
