import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/error_api.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/error_database.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/pages/Mantenimiento/Errores/editar_error.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final errorBloc = ProviderBloc.error(context);
    errorBloc.obtenerErroresPorTipo1();
    errorBloc.obtenerErroresPorTipo2();

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: provider.cargando,
        builder: (BuildContext context, bool data, Widget child) {
          return Stack(
            children: [
              Column(
                children: [
                  StreamBuilder(
                      stream: errorBloc.errorTipo1Stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ErrorModel>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(3),
                                    ),
                                    child: Column(
                                      children: [
                                        RegistroError(responsive: responsive),
                                        Row(
                                          children: [
                                            Text(
                                              'Errores Convencionales',
                                              style: TextStyle(
                                                  fontSize: responsive.ip(1.7),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            Text(
                                              'Opciones',
                                              style: TextStyle(
                                                  fontSize: responsive.ip(1.7),
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
                                    vertical: responsive.hp(.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: responsive.wp(60),
                                        child: Text(
                                          '${snapshot.data[index2].errorNombre}',
                                          style: TextStyle(
                                            fontSize: responsive.ip(1.6),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: responsive.wp(23),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon:
                                                  FaIcon(FontAwesomeIcons.edit),
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
                                                      return EditarError(
                                                          error: snapshot
                                                              .data[index2]);
                                                      //return DetalleProductitos(productosData: productosData);
                                                    },
                                                    transitionsBuilder:
                                                        (context,
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
                                                final errorApi = ErrorApi();
                                                provider.setValor(true);
                                                final res = await errorApi
                                                    .eliminarError(
                                                        '${snapshot.data[index2].idError}');

                                                if (res) {
                                                  final errorDatabase =
                                                      ErrorDatabase();

                                                  await errorDatabase
                                                      .deleteErrorPorId(
                                                    '${snapshot.data[index2].idError}',
                                                  );
                                                }
                                                provider.setValor(false);
                                                errorBloc.obtenerErrores();
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
                                RegistroError(responsive: responsive),
                                Text('Aún no se registro Errores')
                              ],
                            );
                          }
                        } else {
                          return Column(
                            children: [
                              RegistroError(responsive: responsive),
                              Text('Aún no se registro Errores')
                            ],
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: errorBloc.errorTipo2Stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ErrorModel>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length > 0) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(3),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Otros Errores ',
                                              style: TextStyle(
                                                  fontSize: responsive.ip(1.7),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Spacer(),
                                            Text(
                                              'Opciones',
                                              style: TextStyle(
                                                  fontSize: responsive.ip(1.7),
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
                                    vertical: responsive.hp(.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: responsive.wp(60),
                                        child: Text(
                                          '${snapshot.data[index2].errorNombre}',
                                          style: TextStyle(
                                            fontSize: responsive.ip(1.6),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: responsive.wp(23),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              icon:
                                                  FaIcon(FontAwesomeIcons.edit),
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
                                                      return EditarError(
                                                          error: snapshot
                                                              .data[index2]);
                                                      //return DetalleProductitos(productosData: productosData);
                                                    },
                                                    transitionsBuilder:
                                                        (context,
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
                                                final errorApi = ErrorApi();
                                                provider.setValor(true);
                                                final res = await errorApi
                                                    .eliminarError(
                                                        '${snapshot.data[index2].idError}');

                                                if (res) {
                                                  final errorDatabase =
                                                      ErrorDatabase();

                                                  await errorDatabase
                                                      .deleteErrorPorId(
                                                    '${snapshot.data[index2].idError}',
                                                  );
                                                }
                                                provider.setValor(false);
                                                errorBloc.obtenerErrores();
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
                                 
                                Text('Aún no se registro Otros Errores')
                              ],
                            );
                          }
                        } else {
                          return Column(
                            children: [
                               
                              Text('Aún no se registro Otros Errores')
                            ],
                          );
                        }
                      }),
                ],
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
        },
      ),
    );
  }
}

class RegistroError extends StatefulWidget {
  const RegistroError({
    Key key,
    @required this.responsive,
    this.algo,
  }) : super(key: key);

  final Responsive responsive;
  final ValueListenable algo;

  @override
  _RegistroErrorState createState() => _RegistroErrorState();
}

class _RegistroErrorState extends State<RegistroError> {
  TextEditingController _errorController = new TextEditingController();

  @override
  void dispose() {
    _errorController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BlocCargando>(context, listen: false);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: widget.responsive.hp(2),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
      ),
      child: Column(
        children: [
          Text(
            'Registro de Errores',
            style: TextStyle(
                fontSize: widget.responsive.ip(2), fontWeight: FontWeight.w700),
          ),
          Divider(
            color: Colors.black,
            thickness: .5,
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Error :',
                style: TextStyle(
                    fontSize: widget.responsive.ip(1.6),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: widget.responsive.wp(5),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.responsive.wp(2),
                ),
                width: widget.responsive.wp(60),
                color: Colors.grey[200],
                height: widget.responsive.hp(5),
                child: TextField(
                  cursorColor: Colors.transparent,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.black45,
                        fontSize: widget.responsive.ip(1.7),
                      ),
                      hintText: 'Error '),
                  enableInteractiveSelection: false,
                  controller: _errorController,
                ),
              )
            ],
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () async {
              if (_errorController.text.length > 0) {
                final errorApi = ErrorApi();
                final errorBloc = ProviderBloc.error(context);
                provider.setValor(true);
                final res =
                    await errorApi.guardarError(_errorController.text, '1');

                provider.setValor(false);

                if (res) {
                  registroCorrecto('Registro completo');
                } else {
                  registroCorrecto('Registro fallido');
                }

                _errorController.text = '';

                errorBloc.obtenerErrores();
              } else {
                print('debe registar un nombre para la gerencia');
              }
            },
            child: Text(
              'Registrar',
              style: TextStyle(
                  fontSize: widget.responsive.ip(1.5), color: Colors.white),
            ),
          )
        ],
      ),
    );
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
