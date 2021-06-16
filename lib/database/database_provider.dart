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

    final path = join(documentsDirectory.path, 'helpDesk.db');

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
            ' idPerson TEXT PRIMARY KEY,'
            ' dni TEXT,'
            ' nombre TEXT,'
            ' apellido TEXT,'
            ' idGerencia TEXT,'
            ' idArea TEXT,'
            ' nivelUsuario TEXT'
            ')');

        await db.execute(' CREATE TABLE Usuario('
            ' idUsuario TEXT PRIMARY KEY,'
            ' dni TEXT,'
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

        await db.execute(' CREATE TABLE Equipos('
            ' idEquipo TEXT PRIMARY KEY,'
            ' idGerencia TEXT,'
            ' idArea TEXT,'
            ' equipoCodigo TEXT,'
            ' equipoNombre TEXT,'
            ' equipoIp TEXT,'
            ' equipoMac TEXT'
            ')');

        //errorTipo=0)?'Normal':'Otros'
        await db.execute(' CREATE TABLE Error('
            ' idError TEXT PRIMARY KEY,'
            ' errorNombre TEXT,'
            ' errorTipo TEXT'
            ')');

        await db.execute(' CREATE TABLE FallaEquipos('
            ' idFalla TEXT PRIMARY KEY,'
            ' idSolicitante TEXT,'
            ' idEquipo TEXT,'
            ' idError TEXT,'
            ' otroError TEXT,'
            ' fecha TEXT,'
            ' hora TEXT,'
            ' detalleError TEXT,'
            ' estado TEXT'
            ')');



             await db.execute(' CREATE TABLE Atenciones('
            ' idAtencion TEXT PRIMARY KEY,'
            ' idSoporte TEXT,'
            ' horaRecepcion TEXT,'
            ' idResponsable TEXT,'
            ' gravedad TEXT,'
            ' horaReparacion TEXT,'
            ' idReceptorEquipo TEXT,'
            ' horaDevolucion TEXT,'
            ' estado TEXT'
            ')');
      },
    );
  }
}
