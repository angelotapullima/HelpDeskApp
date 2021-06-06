import 'dart:convert';

import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  final prefs = new Preferences();

  Future<int> login(String user, String pass) async {
    try {
      final url = '$apiBaseURL/api/datos/iniciar_sesion';

      final resp = await http.post(
        Uri.parse(url),
        body: {
          'usuario_nick': '$user',
          'usuario_pass': '$pass',
        },
      );

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];

      if (code == 1) {
        //final prodTemp = Data.fromJson(decodedData['data']);
        var valorID = decodedData['data']['id_persona'];
        prefs.idUsuario = valorID;
        prefs.idPersona = valorID;
        prefs.userNickname = decodedData['data']['usuario_nick'];
        prefs.userEmail = decodedData['data']['usuario_email'];
        prefs.usuarioTelefono = decodedData['data']['usuario_telefono'];
        prefs.usuarioEstado = decodedData['data']['usuario_estado'];
        prefs.idGerencia = decodedData['data']['id_gerencia'];
        prefs.idNivel = decodedData['data']['id_nivel'];
        prefs.idArea = decodedData['data']['id_area'];
        prefs.personDni = decodedData['data']['persona_dni'];
        prefs.personaNombre = decodedData['data']['persona_nombre'];
        prefs.personaApellido = decodedData['data']['persona_apellido'];
        

        return code;
      } else {
        return code;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 0;
    }
  }
}
