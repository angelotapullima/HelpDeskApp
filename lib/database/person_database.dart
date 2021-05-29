


import 'package:help_desk_app/models/person_model.dart';

import 'database_provider.dart';

class PersonDatabase{


   final dbprovider = DatabaseProvider.db;

  insertarPersona(PersonModel personModel)async{
    try{
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Persona (idPerson,dni,nombre,apellido,idGerencia,idArea,nivelUsuario) "
          "VALUES ('${personModel.idPerson}','${personModel.dni}','${personModel.nombre}','${personModel.apellido}','${personModel.idGerencia}',"
          "'${personModel.idArea}','${personModel.nivelUsuario}')");
      return res;

    }catch(exception){
      print(exception);
    }
  }



  Future<List<PersonModel>> obtenerPersonas() async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Persona");

    List<PersonModel> list = res.isNotEmpty
        ? res.map((c) => PersonModel.fromJson(c)).toList()
        : [];

    return list;
  } 


  Future<List<PersonModel>> obtenerPersonaPorDni(String id) async {
    final db = await dbprovider.database;
    final res =
    await db.rawQuery("SELECT * FROM Persona WHERE dni='$id'");

    List<PersonModel> list = res.isNotEmpty
        ? res.map((c) => PersonModel.fromJson(c)).toList()
        : [];

    return list;
  } 






  updatePersona(int id, String idGerencia, String nombreArea) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawUpdate(
          "UPDATE Persona SET "
          "idGerencia='$idGerencia', "
          "nombreArea='$nombreArea' "
          "WHERE  idArea= '$id' ");
      print(res);
      return res;
    } catch (exception) {
      print(exception);
    }
  }

  deletePersonaPorDni(String dni) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Persona where dni="$dni"');

    return res;
  }


}