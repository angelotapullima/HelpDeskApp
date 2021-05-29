import 'dart:convert';

import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class GerenciaApi {
  final prefs = new Preferences();

  final gerenciaDatabase = GerenciaDatabase();

  Future<bool> guardarGerencia(String nombreGerencia) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_gerencia');

      final resp =
          await http.post(url, body: {'gerencia_nombre': '$nombreGerencia'});

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

  Future<bool> editarGerencia(String idGerencia, String nombreGerencia) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_gerencia');

      final resp = await http.post(url, body: {
        'id_gerencia': '$idGerencia',
        'gerencia_nombre': '$nombreGerencia',
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



  Future<bool> eliminarGerencia(String idGerencia) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_gerencia');

      final resp = await http.post(url, body: {
        'id_gerencia': '$idGerencia',
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

  Future<bool> listarGerencia() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_gerencias');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          GerenciaModel gerenciaModel = GerenciaModel();
          gerenciaModel.idGerencia =decodedData['data'][i]['id_gerencia'].toString();
          gerenciaModel.nombreGerencia = decodedData['data'][i]['gerencia_nombre'].toString();

          await gerenciaDatabase.insertarGerencia(gerenciaModel);
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
