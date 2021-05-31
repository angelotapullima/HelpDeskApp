import 'package:flutter/material.dart';
import 'package:help_desk_app/pages/Atenciones/guardar_atencion.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:help_desk_app/utils/responsive.dart';

class AtencionesPage extends StatelessWidget {
  const AtencionesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
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
                      '2021-05-20',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(1.5),
                      ),
                    ),
                    SizedBox(
                      width: responsive.wp(5),
                    ),
                    Text(
                      '4:30pm',
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
                  '$errorDeLAPtmr',
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return GuardarAtencion();
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
      ),
    );
  }
}
