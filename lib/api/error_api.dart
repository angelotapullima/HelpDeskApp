import 'dart:convert';
import 'package:help_desk_app/database/error_database.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class ErrorApi {
  final prefs = new Preferences();

  final errorDatabase = ErrorDatabase();

  Future<bool> guardarError(String nombreError, String tipo) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_error');

      final resp = await http.post(url, body: {
        'error_nombre': '$nombreError',
        'error_tipo': '$tipo',
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

  Future<bool> editarError(String idError,String nombreError, String tipo) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/guardar_error');

      final resp = await http.post(url, body: {
        'id_error': '$idError',
        'error_nombre': '$nombreError',
        'error_tipo': '$tipo',
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

  Future<bool> eliminarError(String idError) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/eliminar_error');

      final resp = await http.post(url, body: {
        'id_error': '$idError',
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

  Future<bool> listarErrores() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/datos/listar_errores');

      final resp = await http.post(url, body: {});

      final decodedData = json.decode(resp.body);

      if (decodedData['data'].length > 0) {
        for (var i = 0; i < decodedData['data'].length; i++) {
          ErrorModel errorModel = ErrorModel();
          errorModel.idError =decodedData['data'][i]['id_error'].toString();
          errorModel.errorNombre =decodedData['data'][i]['error_nombre'].toString();
          errorModel.errorTipo =decodedData['data'][i]['error_tipo'].toString();

          await errorDatabase.insertarError(errorModel);
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
