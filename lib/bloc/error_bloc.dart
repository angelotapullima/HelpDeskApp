

 
import 'package:help_desk_app/api/error_api.dart';
import 'package:help_desk_app/database/error_database.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:rxdart/rxdart.dart';

class ErrorBloc {
  final errorDatabase = ErrorDatabase();
  final errorApi = ErrorApi();

  final _errorController = BehaviorSubject<List<ErrorModel>>();

  Stream<List<ErrorModel>> get errorStream =>
      _errorController.stream;

  dispose() {
    _errorController?.close();
  }

  void obtenerErrores() async {
    _errorController.sink.add(await errorDatabase.obtenerErrores());
    await errorApi.listarErrores();
    _errorController.sink.add(await errorDatabase.obtenerErrores());
  }
}
