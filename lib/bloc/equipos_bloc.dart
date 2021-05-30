

 
import 'package:help_desk_app/api/equipos_api.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/equipo_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/equipos_model.dart'; 

import 'package:rxdart/rxdart.dart';

class EquiposBloc { 
  final gerenciaDatabase = GerenciaDatabase(); 
  final areaDatabase = AreaDatabase(); 
  final equiposDatabase=EquiposDatabase();
  final equiposApi=EquiposApi();

  final _equiposController = BehaviorSubject<List<EquiposModel>>();

  Stream<List<EquiposModel>> get equiposStream => _equiposController.stream;

  dispose() {
    _equiposController?.close();
  }

  void obtenerEquipos() async {
    _equiposController.sink.add(await personDb());
    await equiposApi.listarEquipos();
    _equiposController.sink.add(await personDb());
  }

  Future<List<EquiposModel>> personDb() async {
    final List<EquiposModel> equiposList = [];

    final resultEquipos = await equiposDatabase.obtenerEquipos();

    if (resultEquipos.length > 0) {
      for (var i = 0; i < resultEquipos.length; i++) {
        final areaList = await areaDatabase.obtenerAreaPorId(resultEquipos[i].idArea);
        final gerenciaList = await gerenciaDatabase.obtenerGerenciaPorId(resultEquipos[i].idGerencia);
        

        EquiposModel equiposModel = EquiposModel();
        equiposModel.idEquipo = resultEquipos[i].idEquipo;
        equiposModel.idGerencia = resultEquipos[i].idGerencia;
        equiposModel.idArea = resultEquipos[i].idArea; 
        equiposModel.nombreGerencia = gerenciaList[0].nombreGerencia;
        equiposModel.nombreArea = areaList[0].nombreArea; 
        equiposModel.equipoCodigo = resultEquipos[i].equipoCodigo; 
        equiposModel.equipoIp = resultEquipos[i].equipoIp; 
        equiposModel.equipoNombre = resultEquipos[i].equipoNombre; 
        equiposModel.equipoMac = resultEquipos[i].equipoMac; 

        equiposList.add(equiposModel);
      }
    }

    return equiposList;
  }
}
