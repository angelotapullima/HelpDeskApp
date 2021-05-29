import 'package:help_desk_app/api/area_api.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:rxdart/rxdart.dart';

class AreaBloc {
  final areaDatabase = AreaDatabase();
  final gerenciaDatabase = GerenciaDatabase();
  final areaApi =AreaApi();

  final _areaController = BehaviorSubject<List<AreaModel>>();
  final _areaPorIdGerenciaController = BehaviorSubject<List<AreaModel>>();

  Stream<List<AreaModel>> get areasStream => _areaController.stream;
  Stream<List<AreaModel>> get areasPorIdStream =>
      _areaPorIdGerenciaController.stream;

  dispose() {
    _areaController?.close();
    _areaPorIdGerenciaController?.close();
  }

  void obtenerAreas() async {

    _areaController.sink.add(await areasBD());
    await areaApi.listarAreas();
    _areaController.sink.add(await areasBD());
  }

  Future<List<AreaModel>> areasBD()async{


    final List<AreaModel> areas = [];

    final areasList = await areaDatabase.obtenerAreas();

    if (areasList.length > 0) {
      for (var i = 0; i < areasList.length; i++) {
        final nombreGerencia = await gerenciaDatabase.obtenerGerenciaPorId(areasList[i].idGerencia);

        AreaModel areaModel = AreaModel();
        areaModel.idArea = areasList[i].idArea;
        areaModel.nombreArea = areasList[i].nombreArea;
        areaModel.idGerencia = areasList[i].idGerencia;
        areaModel.nombreGerencia = (nombreGerencia.length>0)?nombreGerencia[0].nombreGerencia:'';

        areas.add(areaModel);
      }
    }
    print('ella');
    return areas;

  }

  void obtenerAreasPorIdGerencia(String idGerencia) async {
    final List<AreaModel> areas = [];

    final areasList = await areaDatabase.obtenerAreaPorIdGerencia(idGerencia);

    if (areasList.length > 0) {
      for (var i = 0; i < areasList.length; i++) {
        final nombreGerencia = await gerenciaDatabase .obtenerGerenciaPorId(areasList[i].idGerencia);

        AreaModel areaModel = AreaModel();
        areaModel.idArea = areasList[i].idArea;
        areaModel.nombreArea = areasList[i].nombreArea;
        areaModel.idGerencia = areasList[i].idGerencia;
        areaModel.nombreGerencia = nombreGerencia[0].nombreGerencia;

        areas.add(areaModel);
      }
    }
    _areaPorIdGerenciaController.sink.add(areas);
  }
}
