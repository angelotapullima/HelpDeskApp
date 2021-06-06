import 'package:flutter/material.dart';
import 'package:help_desk_app/api/fallas_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/equipos_model.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class ReporteFallas extends StatefulWidget {
  const ReporteFallas({Key key, @required this.equiposModel}) : super(key: key);

  final EquiposModel equiposModel;

  @override
  _ReporteFallasState createState() => _ReporteFallasState();
}

class _ReporteFallasState extends State<ReporteFallas> {
  TextEditingController _otroErrorControler = new TextEditingController();
  TextEditingController _detalleErrorController = new TextEditingController();

  //datos Area
  String dropdownTipoError = '';
  List<String> listErrores = [];
  bool cantItemsError = true;
  String idError = 'Seleccionar';

  final keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _otroErrorControler.dispose();
    _detalleErrorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final provider = Provider.of<BlocCargando>(context, listen: false);
    final preferences = Preferences();
    return Scaffold(
      appBar: AppBar(
        title: Text('Reporte Fallas'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: keyForm,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingrese detalle de de las fallas',
                            style: TextStyle(
                              fontSize: responsive.ip(1.8),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(4),
                          ),
                          Text(
                            'Nombre Del solicitante:',
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
                            child: Center(
                              child: Text(
                                  '${preferences.personaNombre} ${preferences.personaApellido}'
                                  //controller: _nombreController,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Dni del solicitante',
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
                            child: Center(
                              child: Text('${preferences.personDni}'
                                  //controller: _nombreController,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Código de Equipo',
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
                            child: Center(
                              child: Text('${widget.equiposModel.equipoCodigo}'
                                  //controller: _nombreController,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Nombre de Equipo',
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
                            child: Center(
                              child: Text('${widget.equiposModel.equipoNombre}'
                                  //controller: _nombreController,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Tipo de Error :',
                            style: TextStyle(
                                fontSize: responsive.ip(1.6),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          _selectError(context, responsive),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Otro Error :',
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
                                  hintText: 'Otro Error'),
                              validator: (value) {
                                /* if (value.isEmpty) {
                                return 'El campo no debe estar vacio';
                              } else {
                                return null;
                              } */
                              },
                              enableInteractiveSelection: false,
                              controller: _otroErrorControler,
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Detalles de la falla :',
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
                            height: responsive.hp(20),
                            child: TextFormField(
                              cursorColor: Colors.transparent,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.black45,
                                    fontSize: responsive.ip(1.7),
                                  ),
                                  hintText: 'Describa la falla del Equipo'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'El campo no debe estar vacio';
                                } else {
                                  return null;
                                }
                              },
                              enableInteractiveSelection: false,
                              controller: _detalleErrorController,
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
                                  if (keyForm.currentState.validate()) {
                                    if (idError != 'Seleccionar') {
                                      final fallasApi = FallasApi();

                                      FallasModel fallasModel = FallasModel();
                                      fallasModel.idError = idError;
                                      fallasModel.idSolicitante =
                                          preferences.idUsuario;
                                      fallasModel.idEquipo =
                                          widget.equiposModel.idEquipo;
                                      fallasModel.otroError =
                                          _otroErrorControler.text;
                                      fallasModel.detalleError =
                                          _detalleErrorController.text;

                                      provider.setValor(true);
                                      final res = await fallasApi
                                          .guardarFalla(fallasModel);
                                      provider.setValor(false);
                                      if (res) {
                                        registroCorrecto('Registro completo');
                                      } else {
                                        registroCorrecto('Registro fallido');
                                      }

                                      /*  _dniController.text = '';
                                                         _nombreController.text = '';
                                                         _apellidoController.text = '';
                                                         idGerencia = 'Seleccionar';
                                                         idArea = 'Seleccionar';
                                                         idNivelU = 'Seleccionar'; */

                                      final personBloc =
                                          ProviderBloc.person(context);
                                      personBloc.obtenerPersonas();
                                    } else {
                                      print('debe Seleccionar una gerencia ');
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            height: responsive.hp(6),
                          )
                        ],
                      ),
                    ),
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

  //Area
  Widget _selectError(BuildContext context, Responsive responsive) {
    final errorBloc = ProviderBloc.error(context);
    errorBloc.obtenerErroresPorTipo1();
    return StreamBuilder(
      stream: errorBloc.errorTipo1Stream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ErrorModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (cantItemsError) {
              listErrores.clear();

              listErrores.add('Seleccionar');
              for (int i = 0; i < snapshot.data.length; i++) {
                String nombreCanchas = snapshot.data[i].errorNombre;
                listErrores.add(nombreCanchas);
              }
              dropdownTipoError = "Seleccionar";
              cantItemsError = false;
            }
            return _error(responsive, snapshot.data, listErrores);
          } else {
            listErrores.clear();

            listErrores.add('Seleccionar');
            dropdownTipoError = "Seleccionar";

            return _error(responsive, [], listErrores);
          }
        } else {
          listErrores.clear();

          listErrores.add('Seleccionar');
          dropdownTipoError = "Seleccionar";

          return _error(responsive, [], listErrores);
        }
      },
    );
  }

  Widget _error(
      Responsive responsive, List<ErrorModel> areas, List<String> equipe) {
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
            value: dropdownTipoError,
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
                dropdownTipoError = data;
                //cantItemsArea++;
                obtenerIdError(data, areas);
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

  void obtenerIdError(String dato, List<ErrorModel> list) {
    if (dato == 'Seleccionar') {
      idError = 'Seleccionar';
    } else {
      for (int i = 0; i < list.length; i++) {
        if (dato == list[i].errorNombre) {
          idError = list[i].idError.toString();
        }
      }
    }
    print('idEquipo $idError');
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
