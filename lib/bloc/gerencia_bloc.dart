import 'package:help_desk_app/api/gerencia_api.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:rxdart/rxdart.dart';

class GerenciaBloc {
  final gerenciaDatabase = GerenciaDatabase();
  final gerenciaApi = GerenciaApi();

  final _gerenciasController = BehaviorSubject<List<GerenciaModel>>();

  Stream<List<GerenciaModel>> get gerenciasStream =>
      _gerenciasController.stream;

  dispose() {
    _gerenciasController?.close();
  }

  void obtenerGerencias() async {
    _gerenciasController.sink.add(await gerenciaDatabase.obtenerGerencias());
    await gerenciaApi.listarGerencia();
    _gerenciasController.sink.add(await gerenciaDatabase.obtenerGerencias());
  }
}
