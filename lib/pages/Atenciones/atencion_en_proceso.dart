import 'package:flutter/material.dart';
import 'package:help_desk_app/api/atencion_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:intl/intl.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:provider/provider.dart';

class AtenderSoporte extends StatefulWidget {
  const AtenderSoporte({Key key, @required this.fallas}) : super(key: key);

  final FallasModel fallas;

  @override
  _AtenderSoporteState createState() => _AtenderSoporteState();
}

class _AtenderSoporteState extends State<AtenderSoporte> {
  TextEditingController _horaRecepcionController = new TextEditingController();

//datos Person
  String dropdownPerson = '';
  List<String> listPersom = [];
  int cantItemsPersom = 0;
  String idPerson = 'Seleccionar';

  String horaRecepcion;

  @override
  void dispose() {
    _horaRecepcionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Atención ${widget.fallas.idFalla}'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(2),
                          vertical: responsive.hp(2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Angelo Tapullima Del Aguila',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(1.5),
                              ),
                            ),
                            SizedBox(
                              height: responsive.hp(.5),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.fallas.fecha}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(1.5),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: responsive.hp(.8),
                            ),
                            Text(
                              'Detalle del Problema:',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: responsive.ip(1.5),
                              ),
                            ),
                            SizedBox(
                              height: responsive.hp(1),
                            ),
                            Text(
                              '${widget.fallas.detalleError}',
                              style: TextStyle(
                                fontSize: responsive.ip(1.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: responsive.wp(3)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Asignar Responsable:',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.6),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: responsive.hp(1),
                            ),
                            _selectperson(context, responsive),
                            SizedBox(
                              height: responsive.hp(2),
                            ),
                            Text(
                              'Hora recepción:',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.6),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: responsive.hp(1),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(1),
                              ),
                              width: responsive.wp(100),
                              height: responsive.hp(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    color: Colors.green,
                                  ),
                                  SizedBox(
                                    width: responsive.wp(2),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      cursorColor: Colors.transparent,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: 'Fecha'),
                                      enableInteractiveSelection: false,
                                      controller: _horaRecepcionController,
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                        _selectHoraRecepcion(context);
                                      },
                                    ),
                                  )
                                ],
                              ),
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
                                      fontSize: responsive.ip(1.7),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_horaRecepcionController.text.length >
                                        0) {
                                      if (idPerson == 'Seleccionar') {
                                        print(
                                            'Por Favor seleccione un responsable');
                                      } else {
                                        final atencionApi = AtencionApi();

                                        DateTime now = DateTime.now();

                                        String valor =
                                            "${now.year.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} $horaRecepcion";

                                        provider.setValor(true);
                                        final res =
                                            await atencionApi.guardarAtencion1(
                                                idPerson,
                                                valor,
                                                widget.fallas.idFalla);
                                        provider.setValor(false);
                                        if (res) {
                                          registroCorrecto('Registro completo');
                                        } else {
                                          registroCorrecto('Registro fallido');
                                        }
                                        _horaRecepcionController.text = '';

                                        final fallsEquiposBloc =
                                            ProviderBloc.fallas(context);
                                        fallsEquiposBloc.obtenerFallasEquiposEnProceso();
                                        fallsEquiposBloc.obtenerFallasEquiposSinAtender();
                                      }
                                    } else {
                                      print(
                                          'Por Favor ingrese la hora de la recepcion');
                                    }
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

  Widget _selectperson(BuildContext context, Responsive responsive) {
    final personBloc = ProviderBloc.person(context);
    personBloc.obtenerPersonas();
    return StreamBuilder(
      stream: personBloc.personasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<PersonModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItemsPersom == 0) {
              listPersom.clear();

              listPersom.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas =
                    '${snapshot.data[i].nombre} ${snapshot.data[i].apellido}';
                listPersom.add(nombreCanchas);
              }
              dropdownPerson = "Seleccionar";
            }
            return _person(responsive, snapshot.data, listPersom);
          } else {
            listPersom.clear();

            listPersom.add('Seleccionar');
            dropdownPerson = "Seleccionar";

            return _person(responsive, [], listPersom);
          }
        } else {
          listPersom.clear();

          listPersom.add('Seleccionar');
          dropdownPerson = "Seleccionar";

          return _person(responsive, [], listPersom);
        }
      },
    );
  }

  Widget _person(
      Responsive responsive, List<PersonModel> equipos, List<String> equipe) {
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
            value: dropdownPerson,
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
                dropdownPerson = data;
                cantItemsPersom++;
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

  void obtenerIdNivelUsuario(String dato, List<PersonModel> list) {
    if (dato == 'Seleccionar') {
      idPerson = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == '${list[i].nombre} ${list[i].apellido}') {
          idPerson = list[i].dni.toString();
        }
      }
    }
    print('idPerson $idPerson');
  }

  _selectHoraRecepcion(BuildContext context) async {
    TimeOfDay picked = await PlatformDatePicker.showTime(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      showCupertino: true,
    );

    print('date ${picked.hour}: ${picked.minute}');
    if (picked != null) {
      /* print('no se por que se muestra ${picked.year}-${picked.month}-${picked.day}');
      String dia = ''; */

      setState(() {
        _horaRecepcionController.text = formatTime(picked);

        horaRecepcion =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";

        print(_horaRecepcionController.text);
      });
    }
  }

  String formatTime(TimeOfDay time) {
    DateTime current = new DateTime.now();
    current = DateTime(
        current.year, current.month, current.day, time.hour, time.minute);
    DateFormat format = DateFormat.jm();
    return format.format(current);
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
