import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:help_desk_app/pages/Screens/Usuarios/registrar_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';

class ListarUsuarios extends StatelessWidget {
  const ListarUsuarios({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usuarioBloc = ProviderBloc.usuario(context);
    usuarioBloc.obtenerUsuarios();

    final responsive = Responsive.of(context);
    return Scaffold(
      body: StreamBuilder(
        stream: usuarioBloc.usuarioStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {
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
                      vertical: responsive.hp(1)
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(2),
                      vertical: responsive.hp(1),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: responsive.wp(1.5),
                          ),
                          decoration: BoxDecoration(border: Border.all(color: Colors.black45),borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                            fontSize: responsive.ip(1.5),
                                            fontWeight: FontWeight.w700
                                          ),
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
                                            fontSize: responsive.ip(1.5),
                                            fontWeight: FontWeight.w700
                                          ),
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
                                    SizedBox(height: responsive.hp(1),)
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
                                            fontSize: responsive.ip(1.5),
                                            fontWeight: FontWeight.w700
                                          ),
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
