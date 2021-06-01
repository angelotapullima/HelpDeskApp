



import 'package:help_desk_app/models/atenciones_model.dart';

import 'database_provider.dart';

class AtencionesDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarAtenciones(AtencionesModel atencionesModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Atenciones (idAtencion,idSoporte,horaRecepcion,"
          "idResponsable,gravedad,horaReparacion,idReceptorEquipo,horaDevolucion,estado) "
          "VALUES ('${atencionesModel.idAtencion}','${atencionesModel.idSoporte}','${atencionesModel.horaRecepcion}',"
          "'${atencionesModel.idResponsable}','${atencionesModel.gravedad}','${atencionesModel.horaReparacion}','${atencionesModel.idReceptorEquipo}',"
          "'${atencionesModel.horaDevolucion}','${atencionesModel.estado}')");
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
  Future<List<AtencionesModel>> obtenerAtencionesPorEstado(String estado) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Atenciones where estado='$estado' ");

    List<AtencionesModel> list =
        res.isNotEmpty ? res.map((c) => AtencionesModel.fromJson(c)).toList() : [];

    return list;
  }
 
  Future<List<AtencionesModel>> obtenerAtencionesPorId(String idAtencion) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Atenciones WHERE idAtencion='$idAtencion'");

    List<AtencionesModel> list =
        res.isNotEmpty ? res.map((c) => AtencionesModel.fromJson(c)).toList() : [];

    return list;
  }
}
