

import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/database/usuario_database.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:rxdart/rxdart.dart';

class UsuarioBloc{
 
  final personaDatabase = PersonDatabase();
  final usuarioDatabase = UsuarioDatabase();
  final gerenciaDatabase =GerenciaDatabase();
  final areaDatabase =AreaDatabase();

  final _usuarioController  = BehaviorSubject<List<UsuarioModel>>();  
 

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;  

  dispose(){
    _usuarioController?.close();  
  }

  void obtenerUsuarios()async{  


    final List<UsuarioModel> personasList = [];

    final resultPerson = await usuarioDatabase.obtenerUsuarios();

    if(resultPerson.length>0){

      for (var i = 0; i < resultPerson.length; i++) {

        final personList = await personaDatabase.obtenerPersonaPorId(resultPerson[i].idPerson);

        final gerenciaList = await gerenciaDatabase.obtenerGerenciaPorId(personList[0].idGerencia);
        final areaList = await areaDatabase.obtenerAreaPorId(personList[0].idArea);

        UsuarioModel usuarioModel =UsuarioModel();
        usuarioModel.idPerson = resultPerson[i].idPerson;
        usuarioModel.user = resultPerson[i].user;
        usuarioModel.email = resultPerson[i].email;
        usuarioModel.telefono = resultPerson[i].telefono;
        usuarioModel.nombrePerson = '${personList[0].nombre} ${personList[0].apellido}';
        usuarioModel.gerenciaNombre = gerenciaList[0].nombreGerencia;
        usuarioModel.areaNombre = areaList[0].nombreArea;

        personasList.add(usuarioModel);
        
      }

    }
   _usuarioController.sink.add(personasList); 
  }
 

}