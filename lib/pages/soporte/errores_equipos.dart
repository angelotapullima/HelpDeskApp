import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/gerencia_model.dart';
import 'package:help_desk_app/pages/soporte/registro_fallas.dart';
import 'package:help_desk_app/utils/responsive.dart';

class ErroresEquipos extends StatelessWidget {
  const ErroresEquipos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final equiposBloc = ProviderBloc.equipos(context);
    equiposBloc.obtenerEquiposPorArea();

    final responsive = Responsive.of(context);

    return Scaffold(
      body: StreamBuilder(
        stream: equiposBloc.equiposGerenciaStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<GerenciaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.length + 1,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, indexcito) {
                  if (indexcito == 0) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsive.wp(2),
                          vertical: responsive.hp(2)),
                      child: Text(
                        'EQUIPOS POR AREA  \nSeleccione un equipo para reportar un error',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(1.8),
                        ),
                      ),
                    );
                  }

                  int index = indexcito - 1;
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: responsive.hp(3),
                    ),
                    itemCount: snapshot.data[index].areas.length + 1,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (_, index2) {
                      if (index2 == 0) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(2),
                          ),
                          child: Text(
                            '${snapshot.data[index].nombreGerencia}',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.8),
                            ),
                          ),
                        );
                      }

                      int index3 = index2 - 1;
                      return ListView.builder(
                        padding: EdgeInsets.only(top: responsive.hp(1)),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount:
                            snapshot.data[index].areas[index3].equipos.length +
                                1,
                        itemBuilder: (_, index4) {
                          if (index4 == 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(4),
                              ),
                              child: Text(
                                '${snapshot.data[index].areas[index3].nombreArea}',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.ip(1.8),
                                ),
                              ),
                            );
                          }

                          int index5 = index4 - 1;
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: responsive.wp(4.5),
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
                                          '${snapshot.data[index].areas[index3].equipos[index5].equipoNombre}',
                                          style: TextStyle(
                                              fontSize: responsive.ip(1.5),
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    MaterialButton(
                                        color: Colors.green,
                                        child: Text(
                                          'Reportar Error',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: responsive.ip(1.4),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 400),
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) {
                                                return ReporteFallas(equiposModel: snapshot.data[index].areas[index3].equipos[index5],);
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
                                        })
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
                                      border: Border.all(color: Colors.black45),
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
                                                  'Código',
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
                                              '${snapshot.data[index].areas[index3].equipos[index5].equipoCodigo}',
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
                                                  'Ip',
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
                                              '${snapshot.data[index].areas[index3].equipos[index5].equipoIp}',
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
                                                  'MAC',
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
                                              '${snapshot.data[index].areas[index3].equipos[index5].equipoMac}',
                                              style: TextStyle(
                                                fontSize: responsive.ip(1.4),
                                              ),
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
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text('No hay Equipos'),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
