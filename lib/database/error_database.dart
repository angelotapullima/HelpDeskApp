



 

import 'package:help_desk_app/models/error_model.dart';

import 'database_provider.dart';

class ErrorDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarError(ErrorModel errorModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Error (idError,errorNombre,errorTipo) "
          "VALUES ('${errorModel.idError}','${errorModel.errorNombre}','${errorModel.errorTipo}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }

 


  deleteErrorPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Error where idError="$id"');

    return res;
  }

  Future<List<ErrorModel>> obtenerErrores() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Error");

    List<ErrorModel> list = res.isNotEmpty
        ? res.map((c) => ErrorModel.fromJson(c)).toList()
        : [];

    return list;
  } 


  Future<List<ErrorModel>> obtenerErrorPorId(String id) async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Error WHERE idError='$id'");

    List<ErrorModel> list = res.isNotEmpty
        ? res.map((c) => ErrorModel.fromJson(c)).toList()
        : [];

    return list;
  } 
}