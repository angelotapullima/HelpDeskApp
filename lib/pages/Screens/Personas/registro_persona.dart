import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/models/nivel_usuario_model.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/pages/Screens/Personas/lista_persona.dart';
import 'package:help_desk_app/utils/responsive.dart';

class RegistroPersona extends StatefulWidget {
  const RegistroPersona({Key key}) : super(key: key);

  @override
  _RegistroPersonaState createState() => _RegistroPersonaState();
}

class _RegistroPersonaState extends State<RegistroPersona> {
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _apellidoController = new TextEditingController();
  TextEditingController _dniController = new TextEditingController();

  String dropdownNivelU = '';
  List<String> listNivelU = [];
  int cantItemsNivelU = 0;
  String idNivelU = 'Seleccionar';

  //datos Gerencia
  String dropdownGerencia = '';
  List<String> listGerencia = [];
  int cantItemsGerencia = 0;
  String idGerencia = 'Seleccionar';

  //datos Area
  String dropdownArea = '';
  List<String> listArea = [];
  int cantItemsArea = 0;
  String idArea = 'Seleccionar';

  final keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _dniController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: responsive.wp(5),
                  right: responsive.wp(1),
                ),
                child: Row(
                  children: [
                    Text(
                      'Registro de Personas',
                      style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    MaterialButton(
                        elevation: 0,
                        color: Colors.green,
                        child: Text(
                          'Ver personas',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ListarPersonas();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsive.wp(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      color: Colors.grey[200],
                      height: responsive.hp(5),
                      child: TextFormField(
                        cursorColor: Colors.transparent,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: responsive.ip(1.7),
                            ),
                            hintText: 'Nombre'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'El campo no debe estar vacio';
                          } else {
                            return null;
                          }
                        },
                        enableInteractiveSelection: false,
                        controller: _nombreController,
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    Text(
                      'Apellidos :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      color: Colors.grey[200],
                      height: responsive.hp(5),
                      child: TextFormField(
                        cursorColor: Colors.transparent,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: responsive.ip(1.7),
                            ),
                            hintText: 'Apellidos'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'El campo no debe estar vacio';
                          } else {
                            return null;
                          }
                        },
                        enableInteractiveSelection: false,
                        controller: _apellidoController,
                      ),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Text(
                      'Dni :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                      ),
                      color: Colors.grey[200],
                      height: responsive.hp(5),
                      child: TextFormField(
                        cursorColor: Colors.transparent,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: responsive.ip(1.7),
                            ),
                            hintText: 'Dni'),
                        validator: (value) {
                          if (value.isNotEmpty) {
                            if (value.length < 8) {
                              return 'Se debe ingresar más de 8 dígitos ';
                            }
                            return null;
                          } else {
                            return 'El campo no debe estar vacio';
                          }
                        },
                        enableInteractiveSelection: false,
                        controller: _dniController,
                      ),
                    ),
                    Text(
                      'Gerencia :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    _selecGerencia(context, responsive),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Text(
                      'Area :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    _selectArea(context, responsive),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Text(
                      'Nivel de usuario :',
                      style: TextStyle(
                          fontSize: responsive.ip(1.6),
                          fontWeight: FontWeight.w600),
                    ),
                    _seleNivelUsuario(context, responsive),
                    SizedBox(
                      height: responsive.hp(1),
                    ),
                    Row(
                      children: [
                        Spacer(),
                        MaterialButton(
                          color: Colors.blue,
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsive.ip(2),
                            ),
                          ),
                          onPressed: () async {
                            if (keyForm.currentState.validate()) {
                              if (idGerencia != 'Seleccionar') {
                                if (idArea != 'Seleccionar') {
                                  if (idNivelU != 'Seleccionar') {
                                    final personaDatabase = PersonDatabase();

                                    PersonModel personaModel = PersonModel();
                                    personaModel.dni = _dniController.text;
                                    personaModel.nombre =
                                        _nombreController.text;
                                    personaModel.apellido =
                                        _apellidoController.text;
                                    personaModel.idGerencia = idGerencia;
                                    personaModel.idArea = idArea;
                                    personaModel.nivelUsuario = idNivelU;

                                    await personaDatabase
                                        .insertarPersona(personaModel);

                                    _dniController.text = '';
                                    _nombreController.text = '';
                                    _apellidoController.text = '';
                                    idGerencia = 'Seleccionar';
                                    idArea = 'Seleccionar';
                                    idNivelU = 'Seleccionar';

                                    registroCorrecto();
                                  } else {
                                    print(
                                        'debe Seleccionar un nivel de Usuario ');
                                  }
                                } else {
                                  print('debe Seleccionar un área ');
                                }
                              } else {
                                print('debe Seleccionar una gerencia ');
                              }
                            }

                            /* final personaDatabase = PersonDatabase();

                            PersonModel personaModel = PersonModel();

                            await personaDatabase.insertarPersona(personaModel); */
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seleNivelUsuario(BuildContext context, Responsive responsive) {
    final nivelusuarioBloc = ProviderBloc.nivelU(context);
    nivelusuarioBloc.obtenerNivelesDeUsuario();
    return StreamBuilder(
      stream: nivelusuarioBloc.nivelUsuarioStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<NivelUsuarioModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItemsNivelU == 0) {
              listNivelU.clear();

              listNivelU.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas = snapshot.data[i].nombreNivel;
                listNivelU.add(nombreCanchas);
              }
              dropdownNivelU = "Seleccionar";
            }
            return _nivelUsuario(responsive, snapshot.data, listNivelU);
          } else {
            listNivelU.clear();

            listNivelU.add('Seleccionar');
            dropdownNivelU = "Seleccionar";

            return _gerencia(responsive, [], listNivelU);
          }
        } else {
          listNivelU.clear();

          listNivelU.add('Seleccionar');
          dropdownNivelU = "Seleccionar";

          return _gerencia(responsive, [], listNivelU);
        }
      },
    );
  }

  Widget _nivelUsuario(Responsive responsive, List<NivelUsuarioModel> equipos,
      List<String> equipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(0),
          ),
          width: double.infinity,
          height: responsive.hp(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            value: dropdownNivelU,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsive.ip(1.5),
            ),
            underline: Container(),
            onChanged: (String data) {
              setState(() {
                dropdownNivelU = data;
                cantItemsNivelU++;
                obtenerIdNivelUsuario(data, equipos);

                //areaBloc.obtenerAreas();
                //dropdownEquipos(data,equipos);
              });
            },
            items: equipe.map(
              (e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      e,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.ip(1.5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  void obtenerIdNivelUsuario(String dato, List<NivelUsuarioModel> list) {
    if (dato == 'Seleccionar') {
      idNivelU = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].nombreNivel) {
          idNivelU = list[i].idNivel.toString();
        }
      }

      final areaBloc = ProviderBloc.area(context);
      areaBloc.obtenerAreasPorIdGerencia(idNivelU.toString());
    }
    print('idEquipo $idNivelU');
  }

  Widget _selecGerencia(BuildContext context, Responsive responsive) {
    final gerenciaBloc = ProviderBloc.of(context);
    gerenciaBloc.obtenerGerencias();
    return StreamBuilder(
      stream: gerenciaBloc.gerenciasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GerenciaModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItemsGerencia == 0) {
              listGerencia.clear();

              listGerencia.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas = snapshot.data[i].nombreGerencia;
                listGerencia.add(nombreCanchas);
              }
              dropdownGerencia = "Seleccionar";
            }
            return _gerencia(responsive, snapshot.data, listGerencia);
          } else {
            listGerencia.clear();

            listGerencia.add('Seleccionar');
            dropdownGerencia = "Seleccionar";

            return _gerencia(responsive, [], listGerencia);
          }
        } else {
          listGerencia.clear();

          listGerencia.add('Seleccionar');
          dropdownGerencia = "Seleccionar";

          return _gerencia(responsive, [], listGerencia);
        }
      },
    );
  }

  Widget _gerencia(
      Responsive responsive, List<GerenciaModel> equipos, List<String> equipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(0),
          ),
          width: double.infinity,
          height: responsive.hp(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            value: dropdownGerencia,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsive.ip(1.5),
            ),
            underline: Container(),
            onChanged: (String data) {
              setState(() {
                dropdownGerencia = data;
                cantItemsGerencia++;
                obtenerIdGerencia(data, equipos);

                //areaBloc.obtenerAreas();
                //dropdownEquipos(data,equipos);
              });
            },
            items: equipe.map(
              (e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      e,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.ip(1.5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  void obtenerIdGerencia(String dato, List<GerenciaModel> list) {
    if (dato == 'Seleccionar') {
      idGerencia = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].nombreGerencia) {
          idGerencia = list[i].idGerencia.toString();
        }
      }

      final areaBloc = ProviderBloc.area(context);
      areaBloc.obtenerAreasPorIdGerencia(idGerencia.toString());
    }
    print('idEquipo $idGerencia');
  }

  Widget _selectArea(BuildContext context, Responsive responsive) {
    final areaBloc = ProviderBloc.area(context);
    //areaBloc.obtenerAreas();
    return StreamBuilder(
      stream: areaBloc.areasPorIdStream,
      builder: (BuildContext context, AsyncSnapshot<List<AreaModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItemsArea == 0) {
              listArea.clear();

              listArea.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas = snapshot.data[i].nombreArea;
                listArea.add(nombreCanchas);
              }
              dropdownArea = "Seleccionar";
            }
            return _area(responsive, snapshot.data, listArea);
          } else {
            listArea.clear();

            listArea.add('Seleccionar');
            dropdownArea = "Seleccionar";

            return _area(responsive, [], listArea);
          }
        } else {
          listArea.clear();

          listArea.add('Seleccionar');
          dropdownArea = "Seleccionar";

          return _area(responsive, [], listArea);
        }
      },
    );
  }

  Widget _area(
      Responsive responsive, List<AreaModel> areas, List<String> equipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.wp(0),
          ),
          width: double.infinity,
          height: responsive.hp(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(color: Colors.black26),
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            value: dropdownArea,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsive.ip(1.5),
            ),
            underline: Container(),
            onChanged: (String data) {
              setState(() {
                dropdownArea = data;
                cantItemsArea++;
                obtenerIdArea(data, areas);
                //dropdownEquipos(data,equipos);
              });
            },
            items: equipe.map(
              (e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      e,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.ip(1.5),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  void obtenerIdArea(String dato, List<AreaModel> list) {
    if (dato == 'Seleccionar') {
      idArea = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].nombreArea) {
          idArea = list[i].idArea.toString();
        }
      }
    }
    print('idEquipo $idArea');
  }

  void registroCorrecto() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (contextd) {
        final responsive = Responsive.of(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Column(
            children: <Widget>[
              Text(
                'Registro completo',
                style: TextStyle(
                  fontSize: responsive.ip(2),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            MaterialButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text('Continuar'),
            ),
          ],
        );
      },
    );
  }
}
