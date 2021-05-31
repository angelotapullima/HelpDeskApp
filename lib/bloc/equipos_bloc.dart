import 'package:help_desk_app/api/equipos_api.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/equipo_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:help_desk_app/models/equipos_model.dart';
import 'package:help_desk_app/models/gerencia_model.dart';

import 'package:rxdart/rxdart.dart';

class EquiposBloc {
  final gerenciaDatabase = GerenciaDatabase();
  final areaDatabase = AreaDatabase();
  final equiposDatabase = EquiposDatabase();
  final equiposApi = EquiposApi();

  final _equiposController = BehaviorSubject<List<EquiposModel>>();
  final _equiposPorGerenciaController = BehaviorSubject<List<GerenciaModel>>();

  Stream<List<EquiposModel>> get equiposStream => _equiposController.stream;
  Stream<List<GerenciaModel>> get equiposGerenciaStream =>
      _equiposPorGerenciaController.stream;

  dispose() {
    _equiposController?.close();
    _equiposPorGerenciaController?.close();
  }

  void obtenerEquipos() async {
    _equiposController.sink.add(await personDb());
    await equiposApi.listarEquipos();
    _equiposController.sink.add(await personDb());
  }

  void obtenerEquiposPorArea() async {
    _equiposPorGerenciaController.sink.add(await equiposArea());
    await equiposApi.listarEquipos();
    _equiposPorGerenciaController.sink.add(await equiposArea());
  }

  Future<List<EquiposModel>> personDb() async {
    final List<EquiposModel> equiposList = [];

    final resultEquipos = await equiposDatabase.obtenerEquipos();

    if (resultEquipos.length > 0) {
      for (var i = 0; i < resultEquipos.length; i++) {
        final areaList =
            await areaDatabase.obtenerAreaPorId(resultEquipos[i].idArea);
        final gerenciaList = await gerenciaDatabase
            .obtenerGerenciaPorId(resultEquipos[i].idGerencia);

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

  Future<List<GerenciaModel>> equiposArea() async {
    final List<GerenciaModel> gerencias = [];

    final gerenciasListDb = await gerenciaDatabase.obtenerGerencias();

    if (gerenciasListDb.length > 0) {
      for (var i = 0; i < gerenciasListDb.length; i++) {
        final List<AreaModel> areasCreado = [];
        GerenciaModel gerenciaModel = GerenciaModel();
        gerenciaModel.idGerencia = gerenciasListDb[i].idGerencia;
        gerenciaModel.nombreGerencia = gerenciasListDb[i].nombreGerencia;

        final areasListDb = await areaDatabase
            .obtenerAreaPorIdGerencia(gerenciasListDb[i].idGerencia);

        if (areasListDb.length > 0) {
          for (var x = 0; x < areasListDb.length; x++) {
            final List<EquiposModel> equipos = [];
            AreaModel areaModel = AreaModel();
            areaModel.idArea = areasListDb[x].idArea;
            areaModel.idGerencia = areasListDb[x].idGerencia;
            areaModel.nombreArea = areasListDb[x].nombreArea;
            areaModel.nombreGerencia = gerenciasListDb[i].nombreGerencia;

            final equiposlistDB = await equiposDatabase
                .obtenerEquiposPorArea(areasListDb[x].idArea);

            if (equiposlistDB.length > 0) {
              for (var z = 0; z < equiposlistDB.length; z++) {
                EquiposModel equiposModel = EquiposModel();
                equiposModel.idEquipo = equiposlistDB[z].idEquipo;
                equiposModel.idArea = equiposlistDB[z].idArea;
                equiposModel.idGerencia = equiposlistDB[z].idGerencia;
                equiposModel.equipoCodigo = equiposlistDB[z].equipoCodigo;
                equiposModel.equipoIp = equiposlistDB[z].equipoIp;
                equiposModel.equipoMac = equiposlistDB[z].equipoMac;
                equiposModel.equipoNombre = equiposlistDB[z].equipoNombre;
                equiposModel.nombreArea = areasListDb[x].nombreArea;
                equiposModel.nombreGerencia = gerenciasListDb[i].nombreGerencia;

                equipos.add(equiposModel);
              }
            }
            areaModel.equipos = equipos;

            if (equipos.length > 0) {
              areasCreado.add(areaModel);
            }
          }
        }

        gerenciaModel.areas = areasCreado;

        gerencias.add(gerenciaModel);
      }
    }
    print('cmassee');
    return gerencias;
  }
}
