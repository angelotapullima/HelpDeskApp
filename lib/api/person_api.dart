import 'dart:convert';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class PersonApi {
  final prefs = new Preferences();

  final personDatabase = PersonDatabase();

  Future<int> guardarpersona(PersonModel person) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_persona');

      final resp = await http.post(url, body: {
        'id_gerencia': '${person.idGerencia}',
        'id_area': '${person.idArea}',
        'persona_dni': '${person.dni}',
        'persona_nombre': '${person.nombre}',
        'persona_apellido': '${person.apellido}',
        'id_nivel': '${person.nivelUsuario}',
      });

      final decodedData = json.decode(resp.body);

      //Huevo estuvo aqui
      return decodedData['result']['code'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 2;
    }
  }

  Future<int> editarPersona(PersonModel person) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_persona');

      final resp = await http.post(url, body: {
        'id_persona': '${person.idPerson}',
        'id_gerencia': '${person.idGerencia}',
        'id_area': '${person.idArea}',
        'persona_dni': '${person.dni}',
        'persona_nombre': '${person.nombre}',
        'persona_apellido': '${person.apellido}',
        'id_nivel': '${person.nivelUsuario}',
      });

      final decodedData = json.decode(resp.body);

      return decodedData['result']['code']; 
      
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 2;
    }
  }

  Future<bool> eliminarPersona(String idPersona) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_persona');

      final resp = await http.post(url, body: {
        'id_persona': '$idPersona',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData['result']['code'] == 1) {
        //Huevo estuvo aqui
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
//api/datos/listar_gerencias'));

  Future<bool> listarPersonas() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_personas');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          PersonModel personModel = PersonModel();

          personModel.idPerson = decodedData['data'][i]['id_persona'];
          personModel.idGerencia = decodedData['data'][i]['id_gerencia'];
          personModel.nivelUsuario = decodedData['data'][i]['id_nivel'];
          personModel.idArea = decodedData['data'][i]['id_area'];
          personModel.dni = decodedData['data'][i]['persona_dni'];
          personModel.nombre = decodedData['data'][i]['persona_nombre'];
          personModel.apellido = decodedData['data'][i]['persona_apellido'];
          

           if(personModel.idPerson!=null){

          await personDatabase.insertarPersona(personModel);
          }
        }

        //Huevo estuvo aqui
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}
