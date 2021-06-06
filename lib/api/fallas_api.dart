import 'dart:convert';

import 'package:help_desk_app/database/equipo_database.dart';
import 'package:help_desk_app/database/falla_equipos_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/equipos_model.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class FallasApi {

  final fallasEquiposDatabase = FallasEquiposDatabase();
  final personDatabase = PersonDatabase();
  final equiposDatabase = EquiposDatabase();

  final prefs = new Preferences();

  Future<bool> guardarFalla(FallasModel fallas) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_soporte');

      final resp = await http.post(url, body: {
        'id_error': '${fallas.idError}',
        'id_usuario': '${fallas.idSolicitante}',
        'id_equipo': '${fallas.idEquipo}',
        'soporte_otro_error': '${fallas.otroError}',
        'soporte_detalle': '${fallas.detalleError}',
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

  Future<bool> listarFallas() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_soportes');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {

          FallasModel fallasModel = FallasModel();
          fallasModel.idFalla = decodedData['data'][i]['id_soporte'].toString();
          fallasModel.idEquipo = decodedData['data'][i]['id_equipo'].toString();
          fallasModel.idError = decodedData['data'][i]['id_error'].toString();
          fallasModel.otroError = decodedData['data'][i]['soporte_otro_error'].toString();
          fallasModel.fecha = decodedData['data'][i]['soporte_fecha'].toString();
          fallasModel.detalleError = decodedData['data'][i]['soporte_detalle'].toString();
          fallasModel.idSolicitante = decodedData['data'][i]['id_usuario'].toString();
          fallasModel.estado = decodedData['data'][i]['soporte_estado'].toString();

          await fallasEquiposDatabase.insertarFallas(fallasModel);


          PersonModel personModel = PersonModel();
          personModel.idPerson = decodedData['data'][i]['id_persona_persona'];
          personModel.idGerencia = decodedData['data'][i]['id_gerencia_persona'];
          personModel.nivelUsuario = decodedData['data'][i]['id_nivel'];
          personModel.idArea = decodedData['data'][i]['id_area'];
          personModel.dni = decodedData['data'][i]['persona_dni'];
          personModel.nombre = decodedData['data'][i]['persona_nombre'];
          personModel.apellido = decodedData['data'][i]['persona_apellido'];
          if(personModel.idPerson!=null){

          await personDatabase.insertarPersona(personModel);
          }


          EquiposModel equiposModel = EquiposModel();
          equiposModel.idEquipo = decodedData['data'][i]['id_equipo'].toString();
          equiposModel.idGerencia = decodedData['data'][i]['id_gerencia_equipo'].toString();
          equiposModel.idArea = decodedData['data'][i]['id_area_equipo'].toString();
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
