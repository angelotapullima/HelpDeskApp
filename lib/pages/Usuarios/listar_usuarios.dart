import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/usuario_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/usuario_database.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:help_desk_app/pages/Usuarios/editar_usuario.dart';
import 'package:help_desk_app/pages/Usuarios/registrar_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class ListarUsuarios extends StatelessWidget {
  const ListarUsuarios({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioBloc = ProviderBloc.usuario(context);
    usuarioBloc.obtenerUsuarios();

    final responsive = Responsive.of(context);

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                StreamBuilder(
                  stream: usuarioBloc.usuarioStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UsuarioModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return panelArriba(context, responsive);
                            }

                            int index2 = index - 1;

                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: responsive.wp(3),
                                  vertical: responsive.hp(1)),
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(2),
                                vertical: responsive.hp(1),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data[index2].nombrePerson}',
                                            style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '${snapshot.data[index2].gerenciaNombre} > ${snapshot.data[index2].areaNombre}',
                                            style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        width: responsive.wp(28),
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
                                                          return EditarUsario(
                                                            usuario:
                                                                snapshot.data[index2]
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
                                                final usuarioApi = UsuarioApi();
                                                provider.setValor(true);
                                                final res = await usuarioApi
                                                    .eliminarUsuario(
                                                        '${snapshot.data[index2].idUsuario}');

                                                provider.setValor(false);
                                                if (res) {
                                                  final usuarioDatabase =
                                                      UsuarioDatabase();

                                                  await usuarioDatabase
                                                      .deleteUsuarioPorId(
                                                    '${snapshot.data[index2].idUsuario}',
                                                  );
                                                }

                                                usuarioBloc.obtenerUsuarios();
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: responsive.hp(2),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(1.5),
                                    ),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: responsive.hp(2),
                                                child: Center(
                                                  child: Text(
                                                    'Usuario',
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsive.ip(1.5),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Divider(color: Colors.black),
                                              Text(
                                                '${snapshot.data[index2].user}',
                                                style: TextStyle(
                                                  fontSize: responsive.ip(1.4),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: responsive.hp(2),
                                                child: Center(
                                                  child: Text(
                                                    'Email',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsive.ip(1.5),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Divider(color: Colors.black),
                                              Text(
                                                '${snapshot.data[index2].email}',
                                                style: TextStyle(
                                                  fontSize: responsive.ip(1.4),
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsive.hp(1),
                                              )
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: responsive.hp(2),
                                                child: Center(
                                                  child: Text(
                                                    'Teléfono',
                                                    style: TextStyle(
                                                        fontSize:
                                                            responsive.ip(1.5),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              Divider(color: Colors.black),
                                              Text(
                                                '${snapshot.data[index2].telefono}',
                                                style: TextStyle(
                                                  fontSize: responsive.ip(1.4),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
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
                            );
                          },
                        );
                      } else {
                        return panelArriba(context, responsive);
                      }
                    } else {
                      return panelArriba(context, responsive);
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

  Widget panelArriba(BuildContext context, Responsive responsive) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
          child: Row(
            children: [
              Text(
                'Listar Usuarios',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(1.7),
                ),
              ),
              Spacer(),
              MaterialButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return RegistrarUsuario();
                        //return DetalleProductitos(productosData: productosData);
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  'Registar usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.ip(1.4),
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          thickness: .9,
        )
      ],
    );
  }
}
