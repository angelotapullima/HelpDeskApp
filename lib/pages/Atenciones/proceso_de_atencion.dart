import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/atenciones_model.dart';
import 'package:help_desk_app/pages/Atenciones/finalizar_atencion.dart';
import 'package:help_desk_app/utils/responsive.dart';

class ProcesoDeAtencion extends StatelessWidget {
  const ProcesoDeAtencion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final atencionesBloc = ProviderBloc.atenciones(context);
    atencionesBloc.obtenerAtencionesEnProceso();

    return Scaffold(
      body: StreamBuilder(
          stream: atencionesBloc.atencionesEnProcesoStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<AtencionesModel>> snapshot) {
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
                            'Responsable:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          Text(
                            (snapshot.data[index].nombreResponsable.isNotEmpty)
                                ? '${snapshot.data[index].nombreResponsable}'
                                : '-',
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
                                'Hora de Recepción: ${snapshot.data[index].horaRecepcion} ',
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
                            '${snapshot.data[index].problemaDetalle}',
                            style: TextStyle(
                              fontSize: responsive.ip(1.4),
                            ),
                          ),
                          Row(
                            children: [
                              Spacer(),
                              MaterialButton(
                                child: Text(
                                  'Finalizar Atención',
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
                                        return FinalizarAtencion(
                                            fallas: snapshot.data[index]);
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
                                },
                              )
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
