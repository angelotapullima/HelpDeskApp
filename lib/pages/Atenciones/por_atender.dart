import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/falla_model.dart';
import 'package:help_desk_app/pages/Atenciones/atencion_en_proceso.dart'; 
import 'package:help_desk_app/utils/responsive.dart';

class AtencionesPage extends StatelessWidget {
  const AtencionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final fallsEquiposBloc = ProviderBloc.fallas(context);
    fallsEquiposBloc.obtenerFallasEquiposSinAtender();

    return Scaffold(
      body: StreamBuilder(
          stream: fallsEquiposBloc.fallasSinAtenderEquiposStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<FallasModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {

                return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
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
                            '${snapshot.data[index].fecha} -  ${snapshot.data[index].estado}',
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
                        '${snapshot.data[index].detalleError}',
                        style: TextStyle(
                          fontSize: responsive.ip(1.4),
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          MaterialButton(
                              child: Text(
                                'Atender',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.ip(1.5),
                                ),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 400),
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return AtenderSoporte(fallas:snapshot.data[index]);
                                      //return DetalleProductitos(productosData: productosData);
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              })
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          
              } else {
                return Center(
                  child: Text('No existes Atenciones'),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
            }),
    );
  }
}
