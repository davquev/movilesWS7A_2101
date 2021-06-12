import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:projecto_mybd/models/shopping_list.dart';
import 'package:projecto_mybd/models/list_items.dart';

class DbHelper{
  final int version = 1;
  Database db;

  Future<Database> openDb() async{
    if (db == null){
      //la bd no esta creada --> la creo
      db = await openDatabase(join(await getDatabasesPath(),
      'shopping.db'),
      onCreate: (database, version){
        database.execute(
          'CREATE TABLE lists('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'priority INTEGER)');
        database.execute(
            'CREATE TABLE items('
                'id INTEGER PRIMARY KEY,'
                'idList INTEGER,'
                'name TEXT,'
                'quantity TEXT,'
                'note TEXT,'
                + 'FOREIGN KEY(idList) REFERENCES lists(id))');
      }, version: version);
    }
    return db;
  }

  Future testDB() async{
    db = await openDb();

    await db.execute('INSERT INTO lists VALUES (0, "Fruit", 2)');
    await db.execute('INSERT INTO items VALUES (0, 0, "Manzanas", "2 kgs", "Manzanas rojas")');

    List lists = await db.rawQuery('SELECT * FROM lists');
    List items = await db.rawQuery('SELECT * FROM items');

    print(lists[0]);
    print(items[0]);
  }
}