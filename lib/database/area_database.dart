import 'package:help_desk_app/models/area_model.dart';

import 'database_provider.dart';

class AreaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarArea(AreaModel areaModel) async {
    try {
      final db = await dbprovider.database;

      final res = await db
          .rawInsert("INSERT OR REPLACE INTO Area (idArea,idGerencia,nombreArea) "
              "VALUES ('${areaModel.idArea}','${areaModel.idGerencia}','${areaModel.nombreArea}')");
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<AreaModel>> obtenerAreas() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Area");

    List<AreaModel> list =
        res.isNotEmpty ? res.map((c) => AreaModel.fromJson(c)).toList() : [];

    return list;
  }



  Future<List<AreaModel>> obtenerAreaPorIdGerencia(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Area WHERE idGerencia='$id'");

    List<AreaModel> list =
        res.isNotEmpty ? res.map((c) => AreaModel.fromJson(c)).toList() : [];

    return list;
  }


  Future<List<AreaModel>> obtenerAreaPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Area WHERE idArea='$id'");

    List<AreaModel> list =
        res.isNotEmpty ? res.map((c) => AreaModel.fromJson(c)).toList() : [];

    return list;
  }
 

  deleteAreaPorId(String  id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Area where idArea="$id"');

    return res;
  }
}
