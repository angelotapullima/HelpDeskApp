import 'package:flutter/material.dart';
import 'package:help_desk_app/api/area_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/area_model.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class EditarArea extends StatefulWidget {
  const EditarArea({Key key, @required this.area}) : super(key: key);

  final AreaModel area;

  @override
  _EditarAreaState createState() => _EditarAreaState();
}

class _EditarAreaState extends State<EditarArea> {
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
    final responsive = Responsive.of(context);

    final areaBloc = ProviderBloc.area(context);

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Text(
                        'Nombre del área Actual :',
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
                        width: double.infinity,
                        color: Colors.grey[200],
                        height: responsive.hp(4),
                        child: Center(
                          child: Text(
                            '${widget.area.nombreArea}',
                            style: TextStyle(fontSize: responsive.ip(1.6)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Text(
                        'Gerencia a la que pertenece:',
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
                        width: double.infinity,
                        height: responsive.hp(4),
                        color: Colors.grey[200],
                        child: Center(
                          child: Text(
                            '${widget.area.nombreGerencia} ',
                            style: TextStyle(fontSize: responsive.ip(1.6)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        ' :',
                        style: TextStyle(
                            fontSize: responsive.ip(1.6),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Area :',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.6),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: responsive.wp(5),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(2),
                                ),
                                color: Colors.grey[200],
                                height: responsive.hp(4),
                                child: TextField(
                                  cursorColor: Colors.transparent,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Colors.black45,
                                        fontSize: responsive.ip(1.7),
                                      ),
                                      hintText: 'Nombre Area'),
                                  enableInteractiveSelection: false,
                                  controller: _areaController,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(5),
                        ),
                        child: Text(
                          'Seleccionar Gerencia',
                          style: TextStyle(
                              fontSize: responsive.ip(1.6),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(5),
                        ),
                        child: _selecGerencia(context, responsive),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(5),
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

                                    final res = await areaApi.editarArea(
                                        widget.area.idArea,
                                        _areaController.text,
                                        idGerencia);
                                    provider.setValor(false);

                                    if (res) {
                                      registroCorrecto('Registro completo');
                                    } else {
                                      registroCorrecto('Registro fallido');
                                    }
                                    _areaController.text = '';
                                    idGerencia = 'Seleccionar';
                                    dropdownGerencia = 'Seleccionar';
                                    areaBloc.obtenerAreas();
                                    
                                  }
                                } else {
                                  print(
                                      'debe registar un nombre para la gerencia');
                                }
                              },
                              child: Text(
                                'Registrar',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.5),
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                    ],
                  ),
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
