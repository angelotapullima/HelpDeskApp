import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/atenciones_model.dart';
import 'package:help_desk_app/utils/responsive.dart';

class AtencionesFinalizadas extends StatelessWidget {
  const AtencionesFinalizadas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final atencionesBloc = ProviderBloc.atenciones(context);
    atencionesBloc.obternerAtencionesCompletadas();

    return Scaffold(
      body: StreamBuilder(
          stream: atencionesBloc.atencinesCompletadasStream,
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
                          SizedBox(
                            height: responsive.hp(1),
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
                            height: responsive.hp(1),
                          ),
                          Row(
                            children: [
                              Text(
                                'Gravedad : ${snapshot.data[index].gravedad} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: responsive.ip(1.5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Hora Reparación finalizada :  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          Text(
                            '${snapshot.data[index].horaReparacion} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          SizedBox(
                            height: responsive.hp(.8),
                          ),
                          Text(
                            'Encargado del recojo del equipo:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          Text(
                            (snapshot.data[index].nombreRecoge.isNotEmpty)
                                ? '${snapshot.data[index].nombreRecoge}'
                                : '-',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                         SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Hora devolución :  ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          Text(
                            '${snapshot.data[index].horaDevolucion} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(1.5),
                            ),
                          ), SizedBox(
                            height: responsive.hp(1),
                          ),
                          Text(
                            'Detalle del Problema:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: responsive.ip(1.5),
                            ),
                          ),
                          Text(
                            '${snapshot.data[index].problemaDetalle}',
                            style: TextStyle(
                              fontSize: responsive.ip(1.4),
                            ),
                          ),
                          Divider(
                            thickness: 3,
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
