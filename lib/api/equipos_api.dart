import 'dart:convert';

import 'package:help_desk_app/database/equipo_database.dart';
import 'package:help_desk_app/models/equipos_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class EquiposApi {
  final prefs = new Preferences();
  final equiposDatabase = EquiposDatabase();

  Future<bool> guardarEquipos(EquiposModel equipos) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_equipo');

      final resp = await http.post(url, body: {
        'id_gerencia': '${equipos.idGerencia}',
        'id_area': '${equipos.idArea}',
        'equipo_codigo': '${equipos.equipoCodigo}',
        'equipo_nombre': '${equipos.equipoNombre}',
        'equipo_ip': '${equipos.equipoIp}',
        'equipo_mac': '${equipos.equipoMac}',
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

  Future<bool> editarEquipo(EquiposModel equipos) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_equipo');

      final resp = await http.post(url, body: {
        'id_equipo': '${equipos.idEquipo}',
        'id_gerencia': '${equipos.idGerencia}',
        'id_area': '${equipos.idArea}',
        'equipo_codigo': '${equipos.equipoCodigo}',
        'equipo_nombre': '${equipos.equipoNombre}',
        'equipo_ip': '${equipos.equipoIp}',
        'equipo_mac': '${equipos.equipoMac}',
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

  Future<bool> eliminarEquipo(String idEquipo) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_equipo');

      final resp = await http.post(url, body: {
        'id_equipo': '$idEquipo',
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

  Future<bool> listarEquipos() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_equipos');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          EquiposModel equiposModel = EquiposModel();
          equiposModel.idEquipo = decodedData['data'][i]['id_equipo'].toString();
          equiposModel.idGerencia = decodedData['data'][i]['id_gerencia'].toString();
          equiposModel.idArea = decodedData['data'][i]['id_area'].toString();
          equiposModel.equipoCodigo = decodedData['data'][i]['equipo_codigo'].toString();
          equiposModel.equipoNombre = decodedData['data'][i]['equipo_nombre'].toString();
          equiposModel.equipoIp = decodedData['data'][i]['equipo_ip'].toString();
          equiposModel.equipoMac = decodedData['data'][i]['equipo_mac'].toString();

          await equiposDatabase.insertarEquipos(equiposModel);
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
