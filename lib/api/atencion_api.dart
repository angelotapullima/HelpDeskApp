import 'dart:convert';  
import 'package:help_desk_app/database/atenciones_database.dart';
import 'package:help_desk_app/database/equipo_database.dart';
import 'package:help_desk_app/database/falla_equipos_database.dart';
import 'package:help_desk_app/database/usuario_database.dart';
import 'package:help_desk_app/models/atenciones_model.dart';
import 'package:help_desk_app/models/equipos_model.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class AtencionApi {

  final prefs = new Preferences();
  final usuarioDatabase = UsuarioDatabase();
  final fallasEquiposDatabase = FallasEquiposDatabase(); 
  final equiposDatabase = EquiposDatabase();
  final atencionesDatabase=AtencionesDatabase();

  Future<bool> guardarAtencion1(String idUsuario,String fechaHora,String idSoporte) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_atencion');


      final resp = await http.post(url, body: {
        'id_soporte': '$idSoporte',
        'id_persona': '$idUsuario',
        'atencion_recepcion': '$fechaHora',/* 
        'atencion_gravedad': '',
        'atencion_reparacion_hora': '',
        'atencion_reparacion_devolucion': '', */
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
 Future<bool> guardarAtencion2(String idAtencion,String atencionGravedad,String reparacionHora,String reparacionDevolucion,String idPersonRecoge) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_atencion');

      final resp = await http.post(url, body: {
        /* 'id_soporte': '',
        'id_usuario': '',*/
        'id_atencion': '$idAtencion',  
        'atencion_gravedad': '$atencionGravedad',
        'atencion_reparacion_hora': '$reparacionHora',
        'atencion_reparacion_devolucion': '$reparacionDevolucion',
        'id_persona_recojo': '$idPersonRecoge',
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
  
  



  Future<bool> listarAtenciones() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_atenciones');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {

          AtencionesModel atencionesModel = AtencionesModel();
          atencionesModel.idAtencion = decodedData['data'][i]['id_atencion'].toString();
          atencionesModel.idSoporte = decodedData['data'][i]['id_soporte'].toString();
          atencionesModel.idResponsable = decodedData['data'][i]['id_persona_atencion'].toString();
          atencionesModel.horaRecepcion = decodedData['data'][i]['atencion_recepcion'].toString();
          atencionesModel.gravedad = decodedData['data'][i]['atencion_gravedad'].toString();
          atencionesModel.horaReparacion = decodedData['data'][i]['atencion_reparacion_hora'].toString();
          atencionesModel.idReceptorEquipo = decodedData['data'][i]['id_persona_recojo'].toString();
          atencionesModel.horaDevolucion = decodedData['data'][i]['atencion_reparacion_devolucion'].toString();
          atencionesModel.estado = decodedData['data'][i]['atencion_estado'].toString();
        
          await atencionesDatabase.insertarAtenciones(atencionesModel); 


          FallasModel fallasModel = FallasModel();
          fallasModel.idFalla = decodedData['data'][i]['id_soporte'].toString();
          fallasModel.idEquipo = decodedData['data'][i]['id_equipo'].toString();
          fallasModel.idError = decodedData['data'][i]['id_error'].toString();
          fallasModel.otroError = decodedData['data'][i]['soporte_otro_error'].toString();
          fallasModel.fecha = decodedData['data'][i]['soporte_fecha'].toString();
          fallasModel.detalleError = decodedData['data'][i]['soporte_detalle'].toString();
          fallasModel.estado = decodedData['data'][i]['soporte_estado'].toString();

          await fallasEquiposDatabase.insertarFallas(fallasModel);


         /*  PersonModel personModel = PersonModel();
          personModel.idPerson = decodedData['data'][i]['id_persona_persona'];
          personModel.idGerencia = decodedData['data'][i]['id_gerencia_persona'];
          personModel.nivelUsuario = decodedData['data'][i]['id_nivel'];
          personModel.idArea = decodedData['data'][i]['id_area'];
          personModel.dni = decodedData['data'][i]['persona_dni'];
          personModel.nombre = decodedData['data'][i]['persona_nombre'];
          personModel.apellido = decodedData['data'][i]['persona_apellido'];
          if(personModel.idPerson!=null){

          await personDatabase.insertarPersona(personModel);
          } */


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
