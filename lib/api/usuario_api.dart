import 'dart:convert';

import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/database/usuario_database.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class UsuarioApi {
  final prefs = new Preferences();

  final usuarioDatabase = UsuarioDatabase();
  final personDatabase = PersonDatabase();

  Future<int> guardarUsuario(UsuarioModel usuario) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_usuario');

      final resp = await http.post(url, body: {
        'usuario_dni': '${usuario.dni}',
        'usuario_nick': '${usuario.user}',
        'usuario_pass': '${usuario.pass}',
        'usuario_email': '${usuario.email}',
        'usuario_telefono': '${usuario.telefono}',
      });

      final decodedData = json.decode(resp.body);

      //Huevo estuvo aqui
      return decodedData['result']['code'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 2;
    }
  }

  Future<int> editarUsuario(UsuarioModel usuario) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_usuario');

      final resp = await http.post(url, body: {
        'id_usuario': '${usuario.idUsuario}',
        'usuario_dni': '${usuario.dni}',
        'usuario_nick': '${usuario.user}',
        'usuario_pass': '${usuario.pass}',
        'usuario_email': '${usuario.email}',
        'usuario_telefono': '${usuario.telefono}',
      });

      final decodedData = json.decode(resp.body);

      return decodedData['result']['code'];
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 2;
    }
  }

  Future<bool> eliminarUsuario(String idUsuario) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_usuario');

      final resp = await http.post(url, body: {
        'id_usuario': '$idUsuario',
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

  Future<bool> listarUsuarios() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_usuarios');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          UsuarioModel usuarioModel = UsuarioModel();

          usuarioModel.idUsuario = decodedData['data'][i]['id_usuario'];
          usuarioModel.dni = decodedData['data'][i]['persona_dni'];
          usuarioModel.user = decodedData['data'][i]['usuario_nick'];
          usuarioModel.pass = decodedData['data'][i]['usuario_pass'];
          usuarioModel.email = decodedData['data'][i]['usuario_email'];
          usuarioModel.telefono = decodedData['data'][i]['usuario_telefono'];

          await usuarioDatabase.insertarUsuario(usuarioModel);

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
