

 
import 'package:help_desk_app/api/error_api.dart';
import 'package:help_desk_app/database/error_database.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:rxdart/rxdart.dart';

class ErrorBloc {
  final errorDatabase = ErrorDatabase();
  final errorApi = ErrorApi();

  final _errorTipo1Controller = BehaviorSubject<List<ErrorModel>>();
  final _errorTipo2Controller = BehaviorSubject<List<ErrorModel>>();

  Stream<List<ErrorModel>> get errorTipo1Stream =>_errorTipo1Controller.stream;
  Stream<List<ErrorModel>> get errorTipo2Stream =>_errorTipo2Controller.stream;

  dispose() {
    _errorTipo1Controller?.close();
    _errorTipo2Controller?.close();
  }

  void obtenerErroresPorTipo1( ) async {
    _errorTipo1Controller.sink.add(await errorDatabase.obtenerErroresPorTipo('1'));
    await errorApi.listarErrores();
    _errorTipo1Controller.sink.add(await errorDatabase.obtenerErroresPorTipo('1'));
  }


  void obtenerErroresPorTipo2( ) async {
    _errorTipo2Controller.sink.add(await errorDatabase.obtenerErroresPorTipo('2'));
    await errorApi.listarErrores();
    _errorTipo2Controller.sink.add(await errorDatabase.obtenerErroresPorTipo('2'));
  }

  void obtenerErrores() async { 
    await errorApi.listarErrores(); 
  }
}
