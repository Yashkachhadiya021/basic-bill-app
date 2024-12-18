import 'dart:async';
import 'package:bill_management_app/model/ProductData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHepler {
  static final DatabaseHepler instance = DatabaseHepler._internal();

  DatabaseHepler._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    return await db.execute(
      '''CREATE TABLE item(id INTEGER PRIMARY KEY, cname TEXT, cmobile TEXT, iname TEXT, iquantity TEXT, iprice TEXT, iamount TEXT)''',
    );
  }

  Future<void> insertItem(ProductData productdata) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'item',
      productdata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Map<String, dynamic>>> readItems() async {
    // Get a reference to the database.
    final db = await instance.database;

    return db.query('item', orderBy: 'id');
  }

  Future<int> updateItem(int id,String? iname,String? iquantity,String? iprice,String? iamount) async {
    // Get a reference to the database.
    final db = await instance.database;

    final data = {
      'iname': iname,
      'iquantity': iquantity,
      'iprice': iprice,
      'iamount': iamount
    };
    final result=await db.update('item',data,where: "id = ?",whereArgs: [id]);
    return result;

    // await db.update(
    //   'user',
    //   userdata.toMap(),
    //   // Ensure that the Dog has a matching id.
    //   where: 'id = ?',
    //   // Pass the Dog's id as a whereArg to prevent SQL injection.
    //   whereArgs: [userdata.id],
    // );
  }

  Future<void> deleteItem(int id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Remove the Dog from the database.
    await db.delete(
      'item',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


}
