import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/api/person_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/database/person_database.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/pages/Personas/editar_persona.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class ListarPersonas extends StatelessWidget {
  const ListarPersonas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personBloc = ProviderBloc.person(context);
    personBloc.obtenerPersonas();

    final responsive = Responsive.of(context);

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Personas'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                StreamBuilder(
                  stream: personBloc.personasStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PersonModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(2),
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index2) {
                            return Container(
                              //margin: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                              padding: EdgeInsets.symmetric(
                                vertical: responsive.hp(1),
                                horizontal: responsive.wp(2),
                              ),
                              /* decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ), */
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nombre:',
                                            style: TextStyle(
                                              fontSize: responsive.ip(1.5),
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data[index2].nombre} ${snapshot.data[index2].apellido}',
                                            style: TextStyle(
                                              fontSize: responsive.ip(1.5),
                                            ),
                                          ),
                                          SizedBox(
                                            height: responsive.hp(1),
                                          ),
                                          Text(
                                            'Dni:',
                                            style: TextStyle(
                                              fontSize: responsive.ip(1.5),
                                              color: Colors.blue[900],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${snapshot.data[index2].dni}',
                                            style: TextStyle(
                                              fontSize: responsive.ip(1.5),
                                            ),
                                          ),
                                        ],
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
                                                      return EditarPersona(
                                                        person: snapshot
                                                            .data[index2],
                                                      );
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
                                                final personApi = PersonApi();
                                                provider.setValor(true);
                                                final res = await personApi
                                                    .eliminarPersona(
                                                        '${snapshot.data[index2].idPerson}');
                                                if (res) {
                                                  final areaDatabase =
                                                      PersonDatabase();

                                                  await areaDatabase
                                                      .deletePersonaPorDni(
                                                    '${snapshot.data[index2].dni}',
                                                  );
                                                }

                                                provider.setValor(false);

                                                personBloc.obtenerPersonas();
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: responsive.hp(.8),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: responsive.wp(45),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Gerencia',
                                              style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data[index2].nombreGerencia}',
                                              style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: responsive.wp(45),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Área',
                                              style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${snapshot.data[index2].nombreArea}',
                                              style: TextStyle(
                                                fontSize: responsive.ip(1.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No hay personas'),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
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
                  : Container()],
            );
          }),
    );
  }
}
