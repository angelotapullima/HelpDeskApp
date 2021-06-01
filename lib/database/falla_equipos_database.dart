import 'package:help_desk_app/models/falla_model.dart';

import 'database_provider.dart';

class FallasEquiposDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarFallas(FallasModel fallasModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO FallaEquipos (idFalla,idSolicitante,idEquipo,idError,otroError,fecha,hora,detalleError,estado) "
          "VALUES ('${fallasModel.idFalla}','${fallasModel.idSolicitante}','${fallasModel.idEquipo}',"
          "'${fallasModel.idError}','${fallasModel.otroError}','${fallasModel.fecha}','${fallasModel.hora}','${fallasModel.detalleError}','${fallasModel.estado}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }
/* 
  deleteErrorPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Error where idError="$id"');

    return res;
  }
 */
  Future<List<FallasModel>> obtenerFallasEquiposSinAtender() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM FallaEquipos where estado=0 ");

    List<FallasModel> list =
        res.isNotEmpty ? res.map((c) => FallasModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<FallasModel>> fallasEnProceso() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM FallaEquipos where estado=1 ");

    List<FallasModel> list =
        res.isNotEmpty ? res.map((c) => FallasModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<FallasModel>> obtenerFallasEquiposPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM FallaEquipos WHERE idFalla='$id'");

    List<FallasModel> list =
        res.isNotEmpty ? res.map((c) => FallasModel.fromJson(c)).toList() : [];

    return list;
  }
}
