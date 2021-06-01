import 'package:help_desk_app/api/person_api.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/database/nivel_usuario_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/person_model.dart';

import 'package:rxdart/rxdart.dart';

class PersonaBloc {
  final personaDatabase = PersonDatabase();
  final gerenciaDatabase = GerenciaDatabase();
  final nivelUsuarioDatabase = NivelUsuarioDatabase();
  final areaDatabase = AreaDatabase();
  final personApi = PersonApi();

  final _personaController = BehaviorSubject<List<PersonModel>>();

  Stream<List<PersonModel>> get personasStream => _personaController.stream;

  dispose() {
    _personaController?.close();
  }

  void obtenerPersonas() async {
    _personaController.sink.add(await personDb());
    await personApi.listarPersonas();
    _personaController.sink.add(await personDb());
  }

  Future<List<PersonModel>> personDb() async {
    final List<PersonModel> personasList = [];

    final resultPerson = await personaDatabase.obtenerPersonas();

    if (resultPerson.length > 0) {
      for (var i = 0; i < resultPerson.length; i++) {
        final areaList =
            await areaDatabase.obtenerAreaPorId(resultPerson[i].idArea);
        final gerenciaList = await gerenciaDatabase
            .obtenerGerenciaPorId(resultPerson[i].idGerencia);
        final nivelUList = await nivelUsuarioDatabase
            .obtenerNivelUsuarioPorId(resultPerson[i].nivelUsuario);

        PersonModel personModel = PersonModel();
        personModel.idPerson = resultPerson[i].idPerson;
        personModel.dni = resultPerson[i].dni;
        personModel.nombre = resultPerson[i].nombre;
        personModel.apellido = resultPerson[i].apellido;
        personModel.idGerencia = resultPerson[i].idGerencia;
        personModel.idArea = resultPerson[i].idArea;
        personModel.nivelUsuario = resultPerson[i].nivelUsuario;
        personModel.nombreGerencia = (gerenciaList.length>0)?gerenciaList[0].nombreGerencia:'';
        personModel.nombreArea = (areaList.length>0)?areaList[0].nombreArea:'';
        personModel.nombreNivelUsuario = nivelUList[0].nombreNivel;

        personasList.add(personModel);
      }
    }

    return personasList;
  }
}
