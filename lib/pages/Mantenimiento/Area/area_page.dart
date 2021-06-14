import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/area_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/area_database.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/pages/Mantenimiento/Area/editar_area.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class AreaPage extends StatelessWidget {
  const AreaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final areaBloc = ProviderBloc.area(context);
    areaBloc.obtenerAreas();

    final provider = Provider.of<BlocCargando>(context, listen: false);

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                StreamBuilder(
                  stream: areaBloc.areasStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AreaModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3),
                                ),
                                child: Column(
                                  children: [
                                    RegistroGerencia(responsive: responsive),
                                    Row(
                                      children: [
                                        Container(
                                          width: responsive.wp(33),
                                          child: Text(
                                            'Áreas',
                                            style: TextStyle(
                                                fontSize: responsive.ip(1.7),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          width: responsive.wp(33),
                                          child: Text(
                                            'Gerencias',
                                            style: TextStyle(
                                                fontSize: responsive.ip(1.7),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Spacer(),
                                        Text(
                                          'Opciones',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2,
                                    )
                                  ],
                                ),
                              );
                            }
                            int index2 = index - 1;

                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(3),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: responsive.wp(33),
                                    child: Text(
                                      '${snapshot.data[index2].nombreArea}',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: responsive.wp(33),
                                    child: Text(
                                      '${snapshot.data[index2].nombreGerencia}',
                                      style: TextStyle(
                                        fontSize: responsive.ip(1.6),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: responsive.wp(27),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: FaIcon(FontAwesomeIcons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return EditarArea(
                                                    area: snapshot.data[index2],
                                                  );
                                                  //return DetalleProductitos(productosData: productosData);
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            final areaApi = AreaApi();
                                            provider.setValor(true);
                                            final res = await areaApi.eliminarArea(
                                                '${snapshot.data[index2].idArea}');
                                            if (res) {
                                              final areaDatabase =
                                                  AreaDatabase();

                                              await areaDatabase
                                                  .deleteAreaPorId(
                                                '${snapshot.data[index2].idArea}',
                                              );
                                            }

                                            provider.setValor(false);

                                            areaBloc.obtenerAreas();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Column(
                          children: [
                            RegistroGerencia(responsive: responsive),
                            Text('Aún no se registro Gerencias')
                          ],
                        );
                      }
                    } else {
                      return Column(
                        children: [
                          RegistroGerencia(responsive: responsive),
                          Text('Aún no se registro Gerencias')
                        ],
                      );
                    }
                  },
                ),
                (data)
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black.withOpacity(.5),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container()
              ],
            );
          }),
    );
  }
}

class RegistroGerencia extends StatefulWidget {
  const RegistroGerencia({
    Key key,
    @required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  _RegistroGerenciaState createState() => _RegistroGerenciaState();
}

class _RegistroGerenciaState extends State<RegistroGerencia> {
  TextEditingController _areaController = new TextEditingController();

  String dropdownGerencia = '';
  List<String> list = [];
  int cantItemsGerencia = 0;
  String idGerencia = 'Seleccionar';
  @override
  void dispose() {
    _areaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlocCargando>(context, listen: false);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: widget.responsive.hp(2),
        horizontal: widget.responsive.wp(3),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registro de Áreas',
                style: TextStyle(
                    fontSize: widget.responsive.ip(2),
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: .5,
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.responsive.wp(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Area :',
                  style: TextStyle(
                      fontSize: widget.responsive.ip(1.6),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: widget.responsive.wp(5),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.responsive.wp(2),
                    ),
                    color: Colors.grey[200],
                    height: widget.responsive.hp(4),
                    child: TextField(
                      cursorColor: Colors.transparent,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: widget.responsive.ip(1.7),
                          ),
                          hintText: 'Nombre Área'),
                      enableInteractiveSelection: false,
                      controller: _areaController,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: widget.responsive.hp(2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.responsive.wp(5),
            ),
            child: Text(
              'Seleccionar Gerencia',
              style: TextStyle(
                  fontSize: widget.responsive.ip(1.6),
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.responsive.wp(5),
            ),
            child: _selecGerencia(context, widget.responsive),
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.responsive.wp(5),
            ),
            child: Row(
              children: [
                Spacer(),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (_areaController.text.length > 0) {
                      if (idGerencia == 'Seleccionar') {
                        print('se debe asignar una gerencia');
                      } else {
                        final areaApi = AreaApi();

                        provider.setValor(true);

                        final res = await areaApi.guardarArea(
                            _areaController.text, idGerencia);
                        provider.setValor(false);

                        if (res) {
                          registroCorrecto('Registro completo');
                        } else {
                          registroCorrecto('Registro fallido');
                        }

                        final areaBloc = ProviderBloc.area(context);

                        _areaController.text = '';

                        areaBloc.obtenerAreas();
                      }

                      print('area ok');
                      /*  */
                    } else {
                      print('debe registar un nombre para el área');
                    }
                  },
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                        fontSize: widget.responsive.ip(1.5),
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
              list.clear();

              list.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas = snapshot.data[i].nombreGerencia;
                list.add(nombreCanchas);
              }
              dropdownGerencia = "Seleccionar";
            }
            return _gerencia(responsive, snapshot.data, list);
          } else {
            return Container(
              child: Text('mare'),
            );
          }
        } else {
          return Container(
            child: Text('mare2'),
          );
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
                obtenerIdEquipo(data, equipos);
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

  void obtenerIdEquipo(String dato, List<GerenciaModel> list) {
    if (dato == 'Seleccionar') {
      idGerencia = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].nombreGerencia) {
          idGerencia = list[i].idGerencia.toString();
        }
      }
    }
    print('idEquipo $idGerencia');
  }

  void registroCorrecto(String texto) {
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
                '$texto',
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
