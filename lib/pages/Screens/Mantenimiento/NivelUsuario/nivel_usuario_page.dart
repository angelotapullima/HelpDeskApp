import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/nivel_usuario_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/nivel_usuario_database.dart';
import 'package:help_desk_app/models/nivel_usuario_model.dart';
import 'package:help_desk_app/pages/Screens/Mantenimiento/NivelUsuario/editar_nivel_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class NivelUsuarioPage extends StatelessWidget {
  const NivelUsuarioPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final nivelUsuarioBloc = ProviderBloc.nivelU(context);
    nivelUsuarioBloc.obtenerNivelesDeUsuario();

    final provider = Provider.of<BlocCargando>(context, listen: false);

    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                StreamBuilder(
                  stream: nivelUsuarioBloc.nivelUsuarioStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NivelUsuarioModel>> snapshot) {
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
                                    RegistroNivelUsuario(
                                        responsive: responsive),
                                    Row(
                                      children: [
                                        Container(
                                          width: responsive.wp(66),
                                          child: Text(
                                            'Nivel de usuario',
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
                                    width: responsive.wp(66),
                                    child: Text(
                                      '${snapshot.data[index2].nombreNivel}',
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
                                                  return EditarNivelUsuario(
                                                    nombreNivel: snapshot.data[index2].nombreNivel,
                                                    idNivel: snapshot.data[index2].idNivel,
                                                    
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

                                            final nivelUsuarioApi =NivelUsuarioApi();

                                             
                                            provider.setValor(true);
                                            final res = await nivelUsuarioApi.eliminarNivelUsuario(
                                                '${snapshot.data[index2].idNivel}');


                                            provider.setValor(false);

                                            if (res) {
                                              final nivelUsuarioDatabase =
                                                  NivelUsuarioDatabase();

                                              await nivelUsuarioDatabase
                                                  .deleteNivelUsuarioPorId(
                                                '${snapshot.data[index2].idNivel}',
                                              );
                                            }
                                            nivelUsuarioBloc.obtenerNivelesDeUsuario();
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
                            RegistroNivelUsuario(responsive: responsive),
                            Text('Aún no se registro Gerencias')
                          ],
                        );
                      }
                    } else {
                      return Column(
                        children: [
                          RegistroNivelUsuario(responsive: responsive),
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

class RegistroNivelUsuario extends StatefulWidget {
  const RegistroNivelUsuario({
    Key key,
    @required this.responsive,
  }) : super(key: key);

  final Responsive responsive;

  @override
  _RegistroNivelUsuarioState createState() => _RegistroNivelUsuarioState();
}

class _RegistroNivelUsuarioState extends State<RegistroNivelUsuario> {
  TextEditingController _nivelUsuarioControllerController =
      new TextEditingController();

  @override
  void dispose() {
    _nivelUsuarioControllerController.dispose();

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
                'Registro de Nivel de usuario',
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
                  'Nivel :',
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
                          hintText: 'Nivel'),
                      enableInteractiveSelection: false,
                      controller: _nivelUsuarioControllerController,
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
            child: Row(
              children: [
                Spacer(),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (_nivelUsuarioControllerController.text.length > 0) {
                      final nivelUsuarioApi = NivelUsuarioApi();

                      provider.setValor(true);

                      final res = await nivelUsuarioApi.guardarNivelUsuario(
                          _nivelUsuarioControllerController.text);
                      provider.setValor(false);

                      if (res) {
                        registroCorrecto('Registro completo');
                      } else {
                        registroCorrecto('Registro fallido');
                      }

                      final nivelUsuarioBloc = ProviderBloc.nivelU(context);

                      _nivelUsuarioControllerController.text = '';

                      nivelUsuarioBloc.obtenerNivelesDeUsuario();

                      print('area ok');
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
          ),
          SizedBox(
            height: widget.responsive.hp(1),
          ),
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
