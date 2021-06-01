




import 'package:help_desk_app/api/atencion_api.dart';
import 'package:help_desk_app/database/atenciones_database.dart'; 
import 'package:help_desk_app/database/falla_equipos_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/atenciones_model.dart'; 
import 'package:rxdart/rxdart.dart';

class AtencionesBloc {
  final fallasEquiposDatabase = FallasEquiposDatabase(); 
  final atencionesDatabase = AtencionesDatabase();
  final atencionesApi = AtencionApi();
  final personDatabase=PersonDatabase(); 

  final _atencionesProcesoController = BehaviorSubject<List<AtencionesModel>>();
  final _atencionesCompletadasController = BehaviorSubject<List<AtencionesModel>>();

  Stream<List<AtencionesModel>> get atencionesEnProcesoStream => _atencionesProcesoController.stream;
  Stream<List<AtencionesModel>> get atencinesCompletadasStream => _atencionesCompletadasController.stream;

  dispose() {
    _atencionesProcesoController?.close();
    _atencionesCompletadasController?.close();
  }

  void obtenerAtencionesEnProceso() async {
    _atencionesProcesoController.sink
        .add(await obtenerAtencionesProceso());
    await atencionesApi.listarAtenciones();
    _atencionesProcesoController.sink
        .add(await obtenerAtencionesProceso());
  }

  void obternerAtencionesCompletadas() async {
    _atencionesCompletadasController.sink
        .add(await  obtenerAtencionesCompletada());
      
    await atencionesApi.listarAtenciones();
    _atencionesCompletadasController.sink
        .add(await  obtenerAtencionesCompletada());
  }

  Future<List<AtencionesModel>> obtenerAtencionesProceso() async {
    final List<AtencionesModel> fashitas = [];

    final fashasList = await  atencionesDatabase.obtenerAtencionesPorEstado('0');

    if (fashasList.length > 0) {
      for (var i = 0; i < fashasList.length; i++) {

        final persona = await personDatabase.obtenerPersonaPorId(fashasList[i].idResponsable);
        final fallas = await fallasEquiposDatabase.obtenerFallasEquiposPorId(fashasList[i].idSoporte);

        AtencionesModel atencionesModel = AtencionesModel();
        atencionesModel.idAtencion = fashasList[i].idAtencion;
        atencionesModel.idSoporte = fashasList[i].idSoporte; 
        atencionesModel.horaRecepcion = fashasList[i].horaRecepcion; 
        atencionesModel.idResponsable = fashasList[i].idResponsable; 
        atencionesModel.nombreResponsable = (persona.length>0)?'${persona[0].nombre} ${persona[0].apellido}':''; 
        atencionesModel.problemaDetalle = (fallas.length>0)?'${fallas[0].detalleError}  ':''; 


        //completado la atención
        atencionesModel.gravedad = fashasList[i].gravedad; 
        atencionesModel.horaReparacion = fashasList[i].horaReparacion; 
        atencionesModel.idReceptorEquipo = fashasList[i].idReceptorEquipo; 
        atencionesModel.horaDevolucion = fashasList[i].horaDevolucion; 
        atencionesModel.estado = fashasList[i].estado; 

        fashitas.add(atencionesModel);
      }
    }

    return fashitas;
  }





  Future<List<AtencionesModel>> obtenerAtencionesCompletada() async {
    final List<AtencionesModel> fashitas = [];

    final fashasList = await  atencionesDatabase.obtenerAtencionesPorEstado('1');

    if (fashasList.length > 0) {
      for (var i = 0; i < fashasList.length; i++) {

        final personaResponsable = await personDatabase.obtenerPersonaPorId(fashasList[i].idResponsable);
        final personaRecoge = await personDatabase.obtenerPersonaPorId(fashasList[i].idResponsable);
        final fallas = await fallasEquiposDatabase.obtenerFallasEquiposPorId(fashasList[i].idSoporte);

        AtencionesModel atencionesModel = AtencionesModel();
        atencionesModel.idAtencion = fashasList[i].idAtencion;
        atencionesModel.idSoporte = fashasList[i].idSoporte; 
        atencionesModel.horaRecepcion = fashasList[i].horaRecepcion; 
        atencionesModel.idResponsable = fashasList[i].idResponsable; 
        atencionesModel.nombreResponsable = (personaResponsable.length>0)?'${personaResponsable[0].nombre} ${personaResponsable[0].apellido}':''; 
        atencionesModel.problemaDetalle = (fallas.length>0)?'${fallas[0].detalleError}  ':''; 


        //completado la atención
        atencionesModel.gravedad = fashasList[i].gravedad; 
        atencionesModel.horaReparacion = fashasList[i].horaReparacion; 
        atencionesModel.idReceptorEquipo = fashasList[i].idReceptorEquipo; 
        atencionesModel.nombreRecoge = (personaRecoge.length>0)?'${personaRecoge[0].nombre} ${personaRecoge[0].apellido}':''; 
        atencionesModel.horaDevolucion = fashasList[i].horaDevolucion; 
        atencionesModel.estado = fashasList[i].estado; 

        fashitas.add(atencionesModel);
      }
    }

    return fashitas;
  }
}

