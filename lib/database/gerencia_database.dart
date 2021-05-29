






import 'package:help_desk_app/models/gerencia_model.dart'; 

import 'database_provider.dart';

class GerenciaDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarGerencia(GerenciaModel gerenciaModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Gerencia (idGerencia,nombreGerencia) "
          "VALUES ('${gerenciaModel.idGerencia}','${gerenciaModel.nombreGerencia}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }



  updateGerenciaPorID(int id,String nombre) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawUpdate(
          "UPDATE Gerencia SET nombreGerencia='$nombre' WHERE  idGerencia= '$id' ");
      print(res);
      return res;
    } catch (exception) {
      print(exception);
    }
  }


  deleteGerenciaporId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Gerencia where idGerencia="$id"');

    return res;
  }

  Future<List<GerenciaModel>> obtenerGerencias() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Gerencia");

    List<GerenciaModel> list = res.isNotEmpty
        ? res.map((c) => GerenciaModel.fromJson(c)).toList()
        : [];

    return list;
  } 


  Future<List<GerenciaModel>> obtenerGerenciaPorId(String id) async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Gerencia WHERE idGerencia='$id'");

    List<GerenciaModel> list = res.isNotEmpty
        ? res.map((c) => GerenciaModel.fromJson(c)).toList()
        : [];

    return list;
  } 
}