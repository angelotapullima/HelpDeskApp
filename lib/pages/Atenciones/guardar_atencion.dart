import 'package:flutter/material.dart';
import 'package:help_desk_app/utils/constanst.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:intl/intl.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class GuardarAtencion extends StatefulWidget {
  const GuardarAtencion({Key key}) : super(key: key);

  @override
  _GuardarAtencionState createState() => _GuardarAtencionState();
}

class _GuardarAtencionState extends State<GuardarAtencion> {
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _horaRecepcionController = new TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _horaRecepcionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Atención 8'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(3)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asignar Responsable:',
                    style: TextStyle(
                        fontSize: responsive.ip(1.6),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(2),
                    ),
                    color: Colors.grey[200],
                    height: responsive.hp(5),
                    child: TextFormField(
                      cursorColor: Colors.transparent,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: responsive.ip(1.7),
                          ),
                          hintText: 'Nombre'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'El campo no debe estar vacio';
                        } else {
                          return null;
                        }
                      },
                      enableInteractiveSelection: false,
                      controller: _nombreController,
                    ),
                  ),
                  SizedBox(
                    height: responsive.hp(2),
                  ),
                  Text(
                    'Hora recepción:',
                    style: TextStyle(
                        fontSize: responsive.ip(1.6),
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: responsive.hp(1),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsive.wp(1),
                    ),
                    width: responsive.wp(48),
                    height: responsive.hp(6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.transparent,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.black),
                                hintText: 'Fecha'),
                            enableInteractiveSelection: false,
                            controller: _horaRecepcionController,
                            onTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _selectHoraRecepcion(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectHoraRecepcion(BuildContext context) async {
    TimeOfDay picked = await PlatformDatePicker.showTime(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      showCupertino: true,
    );

    print('date ${picked.hour}: ${picked.minute}');
    if (picked != null) {
      /* print('no se por que se muestra ${picked.year}-${picked.month}-${picked.day}');
      String dia = ''; */

      setState(() {
        _horaRecepcionController.text = formatTime(picked);

        print(_horaRecepcionController.text);
      });
    }
  }

  String formatTime(TimeOfDay time) {
    DateTime current = new DateTime.now();
    current = DateTime(
        current.year, current.month, current.day, time.hour, time.minute);
    DateFormat format = DateFormat.jm();
    return format.format(current);
  }
}
