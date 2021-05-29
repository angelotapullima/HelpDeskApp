import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/gerencia_api.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/gerencia_database.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/pages/Screens/Mantenimiento/Gerencia/editar_gerencia.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class GerenciaPage extends StatefulWidget {
  const GerenciaPage({Key key}) : super(key: key);

  @override
  _GerenciaPageState createState() => _GerenciaPageState();
}

class _GerenciaPageState extends State<GerenciaPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final gerenciaBloc = ProviderBloc.of(context);
    gerenciaBloc.obtenerGerencias();

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: provider.cargando,
        builder: (BuildContext context, bool data, Widget child) {
          return Stack(
            children: [
              StreamBuilder(
                  stream: gerenciaBloc.gerenciasStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<GerenciaModel>> snapshot) {
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
                                        Text(
                                          'Gerencias',
                                          style: TextStyle(
                                              fontSize: responsive.ip(2),
                                              fontWeight: FontWeight.w700),
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
                                vertical: responsive.hp(.5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: responsive.wp(60),
                                    child: Text(
                                      '${snapshot.data[index2].nombreGerencia}',
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
                                                  return EditarGerencia(
                                                    nombreGerencia:
                                                        '${snapshot.data[index2].nombreGerencia}',
                                                    idGerencia:
                                                        '${snapshot.data[index2].idGerencia}',
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
                                            final gerenciaApi = GerenciaApi();
                                            provider.setValor(true);
                                            final res = await gerenciaApi
                                                .eliminarGerencia(
                                                    '${snapshot.data[index2].idGerencia}');

                                            if (res) {
                                              final gerenciaDatase =
                                                  GerenciaDatabase();

                                              await gerenciaDatase
                                                  .deleteGerenciaporId(
                                                '${snapshot.data[index2].idGerencia}',
                                              );
                                            }
                                            provider.setValor(false);

                                            gerenciaBloc.obtenerGerencias();
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
                  }),
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

class RegistroGerencia extends StatefulWidget {
  const RegistroGerencia({
    Key key,
    @required this.responsive,
    this.algo,
  }) : super(key: key);

  final Responsive responsive;
  final ValueListenable algo;

  @override
  _RegistroGerenciaState createState() => _RegistroGerenciaState();
}

class _RegistroGerenciaState extends State<RegistroGerencia> {
  TextEditingController _gerenciaController = new TextEditingController();

  @override
  void dispose() {
    _gerenciaController.dispose();

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
            'Registro de Gerencias',
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
                'Gerencia :',
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
                      hintText: 'Nombre Gerencia'),
                  enableInteractiveSelection: false,
                  controller: _gerenciaController,
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
              if (_gerenciaController.text.length > 0) {
                final gerenciaApi = GerenciaApi();
                final gerenciaBloc = ProviderBloc.of(context);
                provider.setValor(true);
                final res =
                    await gerenciaApi.guardarGerencia(_gerenciaController.text);

                provider.setValor(false);

                if (res) {
                  registroCorrecto('Registro completo');
                } else {
                  registroCorrecto('Registro fallido');
                }

                _gerenciaController.text = '';

                gerenciaBloc.obtenerGerencias();
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
