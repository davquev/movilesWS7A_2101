import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projecto_mybd/models/shopping_list.dart';
import 'package:projecto_mybd/models/list_items.dart';

class DbHelper {
  final int version = 1;
  Database db;

  Future<Database> openDb() async {
    if (db == null) {
      //la bd no esta creada --> la creo
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (database, version) {
        database.execute('CREATE TABLE lists('
            'id INTEGER PRIMARY KEY,'
            'name TEXT,'
            'priority INTEGER)');
        database.execute('CREATE TABLE items('
                'id INTEGER PRIMARY KEY,'
                'idList INTEGER,'
                'name TEXT,'
                'quantity TEXT,'
                'note TEXT,' +
            'FOREIGN KEY(idList) REFERENCES lists(id))');
      }, version: version);
    }
    return db;
  }

  Future testDB() async {
    db = await openDb();

    await db.execute('INSERT INTO lists VALUES (2, "Medicinas", 3)');
    //await db.execute('INSERT INTO items VALUES (0, 0, "Manzanas", "2 kgs", "Manzanas rojas")');

    List lists = await db.rawQuery('SELECT * FROM lists');
    List items = await db.rawQuery('SELECT * FROM items');

    print(lists[0]);
    print(items[0]);
  }

  //insertar en tabla lists
  Future<int> insertList(ShoppingList list) async {
    int id = await this.db.insert('lists', list.toMap(),
        conflictAlgorithm:
            ConflictAlgorithm.replace); // opcional, x si hay conflicto

    return id;
  }

  //insertar en tabla items
  Future<int> insertItem(ListItem item) async {
    int id = await this.db.insert('items', item.toMap(),
        conflictAlgorithm:
            ConflictAlgorithm.replace); // opcional, x si hay conflicto

    return id;
  }

  //metodo para mostrar la tabla "lists"
  Future<List<ShoppingList>> getLists() async {
    final List<Map<String, dynamic>> maps = await db.query('lists');

    return List.generate(maps.length, (i) {
      return ShoppingList(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['priority'],
      );
    });
  }

  //metodo para mostrar la tabla "items" a traves del id de "lists"
  Future<List<ListItem>> getItems(int idList) async {
    final List<Map<String, dynamic>> maps = await db.query('items', where: 'idList = ?',
    whereArgs: [idList]);

    return List.generate(maps.length, (i) {
      return ListItem(
        maps[i]['id'],
        maps[i]['idList'],
        maps[i]['name'],
        maps[i]['quantity'],
        maps[i]['note'],
      );
    });
  }
}
