import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'helpDesk345.db');

    Future _onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) {},
      onConfigure: _onConfigure,
      onCreate: (Database db, int version) async {
        await db.execute(' CREATE TABLE Persona('
            ' dni TEXT PRIMARY KEY,'
            ' nombre TEXT,'
            ' apellido TEXT,'
            ' idGerencia TEXT,'
            ' idArea TEXT,'
            ' nivelUsuario TEXT'
            ')');

        await db.execute(' CREATE TABLE Usuario('
            ' idPerson TEXT PRIMARY KEY,'
            ' user TEXT,'
            ' pass TEXT,'
            ' email TEXT,'
            ' telefono TEXT'
            ')');

        await db.execute(' CREATE TABLE Gerencia('
            ' idGerencia TEXT PRIMARY KEY,'
            ' nombreGerencia TEXT'
            ')');

        await db.execute(' CREATE TABLE Area('
            ' idArea TEXT PRIMARY KEY,'
            ' idGerencia TEXT,'
            ' nombreArea TEXT'
            ')');

        await db.execute(' CREATE TABLE NivelUsuario('
            ' idNivel TEXT PRIMARY KEY,'
            ' nombreNivel TEXT'
            ')');
      },
    );
  }
}
