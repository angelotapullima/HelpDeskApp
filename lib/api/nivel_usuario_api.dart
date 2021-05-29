import 'dart:convert';
 
import 'package:help_desk_app/database/nivel_usuario_database.dart';
import 'package:help_desk_app/models/nivel_usuario_model.dart'; 
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class NivelUsuarioApi {
  final prefs = new Preferences();

final nivelUsuarioDatabase =NivelUsuarioDatabase();

  Future<bool> guardarNivelUsuario(String nombreNivel) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_nivel');

      final resp =
          await http.post(url, body: {'nivel_nombre': '$nombreNivel'});

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

  Future<bool> editarNivelUsuario(String idNivel, String nombreNivel) async {
    try {
     final url = Uri.parse('$apiBaseURL/api/datos/guardar_nivel');


      final resp = await http.post(url, body: {
        'id_nivel': '$idNivel',
        'nivel_nombre': '$nombreNivel',
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



  Future<bool> eliminarNivelUsuario(String idNivel) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_nivel');

      final resp = await http.post(url, body: {
        'id_nivel': '$idNivel',
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

  Future<bool> listarNivelesUsuario() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_niveles');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          NivelUsuarioModel nivelUsuarioModel = NivelUsuarioModel();
          nivelUsuarioModel.idNivel =decodedData['data'][i]['id_nivel'].toString();
          nivelUsuarioModel.nombreNivel = decodedData['data'][i]['nivel_nombre'].toString();

          await nivelUsuarioDatabase.insertarNivelUsuario(nivelUsuarioModel);
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
