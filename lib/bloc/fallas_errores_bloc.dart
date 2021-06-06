import 'package:help_desk_app/api/atencion_api.dart';
import 'package:help_desk_app/api/fallas_api.dart';
import 'package:help_desk_app/database/falla_equipos_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:rxdart/rxdart.dart';

class FallasErroresBloc {
  final fallasEquiposDatabase = FallasEquiposDatabase();
  final fallasApi = FallasApi();
  final atencionesApi = AtencionApi();
  final personDatabase = PersonDatabase();

  final _fallasSinAtenderController = BehaviorSubject<List<FallasModel>>();
  final _fallasEnProcesController = BehaviorSubject<List<FallasModel>>();

  Stream<List<FallasModel>> get fallasSinAtenderEquiposStream =>
      _fallasSinAtenderController.stream;
  Stream<List<FallasModel>> get fallasEnProcesoEquiposStream =>
      _fallasEnProcesController.stream;

  dispose() {
    _fallasSinAtenderController?.close();
    _fallasEnProcesController?.close();
  }

  void obtenerFallasEquiposSinAtender() async {
    _fallasSinAtenderController.sink
        .add(await obtenerFashas());
    await fallasApi.listarFallas();
    await atencionesApi.listarAtenciones();
    _fallasSinAtenderController.sink
        .add(await obtenerFashas());
  }

  void obtenerFallasEquiposEnProceso() async {
    _fallasEnProcesController.sink
        .add(await fallasEquiposDatabase.fallasEnProceso());
    await fallasApi.listarFallas();
    await atencionesApi.listarAtenciones();
    _fallasEnProcesController.sink
        .add(await fallasEquiposDatabase.fallasEnProceso());
  }

  Future<List<FallasModel>> obtenerFashas() async {
    final List<FallasModel> fashitas = [];

    final fashasList = await fallasEquiposDatabase.obtenerFallasEquiposSinAtender();

    if (fashasList.length > 0) {
      for (var i = 0; i < fashasList.length; i++) {
        final personaList = await personDatabase.obtenerPersonaPorId(fashasList[i].idSolicitante);
        FallasModel fallasModel = FallasModel();
        fallasModel.idFalla = fashasList[i].idFalla;
        fallasModel.idSolicitante = fashasList[i].idSolicitante;
        fallasModel.nombreSolicitante = (personaList.length>0)?'${personaList[0].nombre} ${personaList[0].apellido}':'';
        fallasModel.idEquipo = fashasList[i].idEquipo;
        fallasModel.nombreEquipo = fashasList[i].idFalla;
        fallasModel.idError = fashasList[i].idError;
        fallasModel.nombreError = fashasList[i].idError;
        fallasModel.otroError = fashasList[i].otroError;
        fallasModel.nombreOtroError = fashasList[i].idError;
        fallasModel.fecha = fashasList[i].fecha;
        fallasModel.hora = fashasList[i].hora;
        fallasModel.detalleError = fashasList[i].detalleError;
        fallasModel.estado = fashasList[i].estado;

        fashitas.add(fallasModel);
      }
    }

    return fashitas;
  }
}
