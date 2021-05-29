import 'package:help_desk_app/database/nivel_usuario_database.dart';
import 'package:help_desk_app/models/nivel_usuario_model.dart';

void ingresarNivelUsuarios() async {
  final nivelUsuarioDatabase = NivelUsuarioDatabase();

  var list = [
    NivelUsuarioModel(idNivel: '1', nombreNivel: 'SuperAdmin'),
    NivelUsuarioModel(idNivel: '2', nombreNivel: 'Admin'),
    NivelUsuarioModel(idNivel: '3', nombreNivel: 'Trabajador'),
  ];

  for (var i = 0; i < list.length; i++) {
    NivelUsuarioModel nivelUsuarioModel = NivelUsuarioModel();
    nivelUsuarioModel.idNivel = list[i].idNivel;
    nivelUsuarioModel.nombreNivel = list[i].nombreNivel;

    await nivelUsuarioDatabase.insertarNivelUsuario(nivelUsuarioModel);
  }
}
