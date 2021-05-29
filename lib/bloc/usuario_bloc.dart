import 'package:help_desk_app/api/usuario_api.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/database/usuario_database.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:rxdart/rxdart.dart';

class UsuarioBloc {
  final personaDatabase = PersonDatabase();
  final usuarioDatabase = UsuarioDatabase();
  final gerenciaDatabase = GerenciaDatabase();
  final areaDatabase = AreaDatabase();
  final usuarioApi = UsuarioApi();

  final _usuarioController = BehaviorSubject<List<UsuarioModel>>();

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;

  dispose() {
    _usuarioController?.close();
  }

  void obtenerUsuarios() async {
    _usuarioController.sink.add(await userDb());
    await usuarioApi.listarUsuarios();
    _usuarioController.sink.add(await userDb());
  }

  Future<List<UsuarioModel>> userDb() async {
    final List<UsuarioModel> personasList = [];

    final resultPerson = await usuarioDatabase.obtenerUsuarios();

    if (resultPerson.length > 0) {
      for (var i = 0; i < resultPerson.length; i++) {
        final personList =
            await personaDatabase.obtenerPersonaPorDni(resultPerson[i].dni);

        if (personList.length > 0) {
          final gerenciaList = await gerenciaDatabase .obtenerGerenciaPorId(personList[0].idGerencia);
          final areaList =
              await areaDatabase.obtenerAreaPorId(personList[0].idArea);

          UsuarioModel usuarioModel = UsuarioModel();
          usuarioModel.idUsuario = resultPerson[i].idUsuario;
          usuarioModel.dni = resultPerson[i].dni;
          usuarioModel.user = resultPerson[i].user;
          usuarioModel.email = resultPerson[i].email;
          usuarioModel.telefono = resultPerson[i].telefono;
          usuarioModel.nombrePerson =
              '${personList[0].nombre} ${personList[0].apellido}';
          usuarioModel.gerenciaNombre = (gerenciaList.length>0)?gerenciaList[0].nombreGerencia:'';
          usuarioModel.areaNombre = (areaList.length>0)?areaList[0].nombreArea:'';

          personasList.add(usuarioModel);
        }
      }
    }

    return personasList;
  }
}
