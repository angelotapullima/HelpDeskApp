import 'package:help_desk_app/models/Usuario_model.dart'; 

import 'database_provider.dart';

class UsuarioDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarUsuario(UsuarioModel usuarioModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Usuario (idPerson,user,pass,email,telefono) "
          "VALUES ('${usuarioModel.idPerson}','${usuarioModel.user}','${usuarioModel.pass}','${usuarioModel.email}',"
          "'${usuarioModel.telefono}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<UsuarioModel>> obtenerUsuarioPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Usuario WHERE idPerson='$id'");

    List<UsuarioModel> list =
        res.isNotEmpty ? res.map((c) => UsuarioModel.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<UsuarioModel>> obtenerUsuarios() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Usuario");

    List<UsuarioModel> list =
        res.isNotEmpty ? res.map((c) => UsuarioModel.fromJson(c)).toList() : [];

    return list;
  }
}
