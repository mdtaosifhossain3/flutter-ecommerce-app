import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //Singleton
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  Database? myDB;

  //Table note
  final String TABLE_CARD = 'card';
  final String COLUMN_CARD_SNO = 's_no';
  final String COLUMN_CARD_TITLE = 'title';
  final String COLUMN_CARD_PRICE = 'price';
  final String COLUMN_NOTE_RATING = 'rating';
  final String COLUMN_NOTE_IMAGE = 'image';
  final String COLUMN_CARD_FOREIGN_KEY = 'key';

  ///db open(path -> if exsist then open else create db)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbpath = join(appDir.path, 'ecommerce.db');

    return await openDatabase(dbpath, onCreate: (db, version) {
      db.execute(
          "create table $TABLE_CARD ($COLUMN_CARD_SNO integer primary key autoincrement,$COLUMN_CARD_FOREIGN_KEY text,  $COLUMN_CARD_TITLE text, $COLUMN_CARD_PRICE text, $COLUMN_NOTE_RATING REAL, $COLUMN_NOTE_IMAGE text)");
    }, version: 1);
  }

  ///all queries
  ///insertion
  Future<bool> addCard(
      {required String title,
      required String price,
      required double rating,
      required String image,
      required String key}) async {
    var db = await getDB();
    //Single Rows - Map
    // Multiple Rows - List

    int rowsEffected = await db.insert(TABLE_CARD, {
      COLUMN_CARD_TITLE: title,
      COLUMN_NOTE_IMAGE: image,
      COLUMN_CARD_PRICE: price,
      COLUMN_NOTE_RATING: rating,
      COLUMN_NOTE_RATING: rating,
      COLUMN_CARD_FOREIGN_KEY: key
    });

    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();

    //Data asbe tobe rows akare. orhtat row onu jai ekta ekta list.
    List<Map<String, dynamic>> mData = await db.query(TABLE_CARD);

    return mData;
  }

  Future<Map<String, dynamic>?> findUserById(String id) async {
    var db = await getDB();
    // Query the database to find a user by the primary key (id)
    List<Map<String, dynamic>> results = await db.query(
      TABLE_CARD, // The table name
      where: '$COLUMN_CARD_FOREIGN_KEY = ?', // The condition (search by id)
      whereArgs: [id], // The arguments to pass (id value)
      limit: 1, // Optional: limit to one result
    );

    // If a user is found, return the first result
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null; // Return null if no user is found
    }
  }

  //Delete Note
  Future<bool> deleteNote({required int sNo}) async {
    if (kDebugMode) {
      print(sNo);
    }
    var db = await getDB();

    int rowEffected =
        await db.delete(TABLE_CARD, where: "$COLUMN_CARD_SNO = $sNo");
    if (kDebugMode) {
      print(rowEffected);
    }
    return rowEffected > 0;
  }

  query(String s,
      {required String where,
      required List<int> whereArgs,
      required int limit}) {}
}
