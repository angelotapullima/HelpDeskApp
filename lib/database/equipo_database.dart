import 'package:help_desk_app/models/equipos_model.dart';

import 'database_provider.dart';

class EquiposDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarEquipos(EquiposModel equipos) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Equipos (idEquipo,"
          "idGerencia,idArea,equipoCodigo,equipoNombre,equipoIp,equipoMac) "
          "VALUES ('${equipos.idEquipo}','${equipos.idGerencia}','${equipos.idArea}',"
          "'${equipos.equipoCodigo}','${equipos.equipoNombre}',"
          "'${equipos.equipoIp}','${equipos.equipoMac}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<EquiposModel>> obtenerEquipos() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Equipos");

    List<EquiposModel> list =
        res.isNotEmpty ? res.map((c) => EquiposModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<EquiposModel>> obtenerEquiposPorArea(String idArea) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Equipos where idArea='$idArea'");

    List<EquiposModel> list =
        res.isNotEmpty ? res.map((c) => EquiposModel.fromJson(c)).toList() : [];

    return list;
  }
/* 
  Future<List<EquiposModel>> obtenerAreaPorIdGerencia(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Area WHERE idGerencia='$id'");

    List<AreaModel> list =
        res.isNotEmpty ? res.map((c) => AreaModel.fromJson(c)).toList() : [];

    return list;
  } */

  Future<List<EquiposModel>> obtenerEquiposPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Equipos WHERE idEquipo='$id'");

    List<EquiposModel> list =
        res.isNotEmpty ? res.map((c) => EquiposModel.fromJson(c)).toList() : [];

    return list;
  }

  deleteEquipoPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Equipos where idEquipo="$id"');

    return res;
  }
}
