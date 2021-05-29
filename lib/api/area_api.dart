import 'dart:convert';

import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class AreaApi {
  final prefs = new Preferences();

  final areaDatabase = AreaDatabase();
  final gerenciaDatabase = GerenciaDatabase();

  Future<bool> guardarArea(String nombreArea, String idGerencia) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_area');

      final resp = await http.post(url, body: {
        'area_nombre': '$nombreArea',
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

  Future<bool> editarArea(
      String idArea, String nombreArea, String idGerencia) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_area');

      final resp = await http.post(url, body: {
        'id_area': '$idArea',
        'id_gerencia': '$idGerencia',
        'area_nombre': '$nombreArea',
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

  Future<bool> eliminarArea(String idArea) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_area');

      final resp = await http.post(url, body: {
        'id_area': '$idArea',
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

  Future<bool> listarAreas() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_areas');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          AreaModel areaApi = AreaModel();
          areaApi.idArea = decodedData['data'][i]['id_area'].toString();
          areaApi.idGerencia = decodedData['data'][i]['id_gerencia'].toString();
          areaApi.nombreArea = decodedData['data'][i]['area_nombre'].toString();

          await areaDatabase.insertarArea(areaApi);

          GerenciaModel gerenciaModel = GerenciaModel();
          gerenciaModel.idGerencia =
              decodedData['data'][i]['id_gerencia'].toString();
          gerenciaModel.nombreGerencia =
              decodedData['data'][i]['gerencia_nombre'].toString();

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
