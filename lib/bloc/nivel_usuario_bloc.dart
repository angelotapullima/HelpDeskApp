



 
 
import 'package:help_desk_app/api/nivel_usuario_api.dart';
import 'package:help_desk_app/database/nivel_usuario_database.dart'; 
import 'package:help_desk_app/models/nivel_usuario_model.dart';
import 'package:rxdart/rxdart.dart';

class NivelUsuarioBloc{
 
  final nivelUsuarioDatabase = NivelUsuarioDatabase();
  final nivelUsuarioApi=NivelUsuarioApi();

  final _nivelUsuarioController  = BehaviorSubject<List<NivelUsuarioModel>>();  
 

  Stream<List<NivelUsuarioModel>> get nivelUsuarioStream => _nivelUsuarioController.stream;  

  dispose(){
    _nivelUsuarioController?.close();  
  }

  void obtenerNivelesDeUsuario()async{  
   _nivelUsuarioController.sink.add(await nivelUsuarioDatabase.obtenerNivelUsuarios());
   await nivelUsuarioApi.listarNivelesUsuario();
   _nivelUsuarioController.sink.add(await nivelUsuarioDatabase.obtenerNivelUsuarios());
  }
 

}