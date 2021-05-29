



import 'package:help_desk_app/models/nivel_usuario_model.dart'; 

import 'database_provider.dart';

class NivelUsuarioDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarNivelUsuario(NivelUsuarioModel nivelUsuarioModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO NivelUsuario (idNivel,nombreNivel) "
          "VALUES ('${nivelUsuarioModel.idNivel}','${nivelUsuarioModel.nombreNivel}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<NivelUsuarioModel>> obtenerNivelUsuarioPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM NivelUsuario WHERE idNivel='$id'");

    List<NivelUsuarioModel> list =
        res.isNotEmpty ? res.map((c) => NivelUsuarioModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<NivelUsuarioModel>> obtenerNivelUsuarios() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM NivelUsuario");

    List<NivelUsuarioModel> list =
        res.isNotEmpty ? res.map((c) => NivelUsuarioModel.fromJson(c)).toList() : [];

    return list;
  }




  deleteNivelUsuarioPorId(String  id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM NivelUsuario where idNivel="$id"');

    return res;
  }
}
