import 'package:flutter/material.dart';
import 'package:help_desk_app/api/gerencia_api.dart';
import 'package:help_desk_app/api/nivel_usuario_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class EditarNivelUsuario extends StatefulWidget {
  const EditarNivelUsuario(
      {Key key, @required this.idNivel, @required this.nombreNivel})
      : super(key: key);

  final String idNivel;
  final String nombreNivel;

  @override
  _EditarNivelUsuarioState createState() => _EditarNivelUsuarioState();
}

class _EditarNivelUsuarioState extends State<EditarNivelUsuario> {
  TextEditingController _nivelController = new TextEditingController();

  @override
  void dispose() {
    _nivelController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final nivelUsuarioBloc = ProviderBloc.nivelU(context);

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: responsive.hp(2),
                      ),
                      Text(
                        'Nombre Actual :',
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
                        width: double.infinity,
                        color: Colors.grey[200],
                        height: responsive.hp(4),
                        child: Center(
                          child: Text(
                            '${widget.nombreNivel}',
                            style: TextStyle(fontSize: responsive.ip(1.6)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Text(
                        'Nuevo Nombre :',
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
                        width: double.infinity,
                        color: Colors.grey[200],
                        height: responsive.hp(4),
                        child: TextField(
                          cursorColor: Colors.transparent,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.black45,
                                fontSize: responsive.ip(1.7),
                              ),
                              hintText: 'Nivel'),
                          enableInteractiveSelection: false,
                          controller: _nivelController,
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () async {
                              if (_nivelController.text.length > 0) {
                                final nivelUsuarioApi = NivelUsuarioApi();
                                provider.setValor(true);
                                final res =
                                    await nivelUsuarioApi.editarNivelUsuario(
                                        widget.idNivel, _nivelController.text);

                                provider.setValor(false);

                                if (res) {
                                  registroCorrecto('Registro completo');
                                } else {
                                  registroCorrecto('Registro fallido');
                                }

                                _nivelController.text = '';
                                nivelUsuarioBloc.obtenerNivelesDeUsuario();
                              } else {
                                print(
                                    'debe registar un nombre para la gerencia');
                              }
                            },
                            child: Text(
                              'Registrar',
                              style: TextStyle(
                                  fontSize: responsive.ip(1.5),
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
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
