import 'package:flutter/material.dart';
import 'package:help_desk_app/api/error_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/error_model.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class EditarError extends StatefulWidget {
  const EditarError({Key key, @required this.error}) : super(key: key);

  final ErrorModel error;

  @override
  _EditarErrorState createState() => _EditarErrorState();
}

class _EditarErrorState extends State<EditarError> {
  TextEditingController _errorNombreController = new TextEditingController();

  @override
  void dispose() {
    _errorNombreController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final errorBloc = ProviderBloc.error(context);

    final provider = Provider.of<BlocCargando>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Error'),
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
                            '${widget.error.errorNombre}',
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
                              hintText: 'Nombre Gerencia'),
                          enableInteractiveSelection: false,
                          controller: _errorNombreController,
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
                              if (_errorNombreController.text.length > 0) {
                                final errorApi = ErrorApi();

                                provider.setValor(true);
                                final res = await errorApi.editarError(
                                  widget.error.idError,
                                  _errorNombreController.text,
                                  widget.error.errorTipo,
                                );

                                provider.setValor(false);

                                if (res) {
                                  registroCorrecto('Registro completo');
                                } else {
                                  registroCorrecto('Registro fallido');
                                }

                                _errorNombreController.text = '';
                                errorBloc.obtenerErrores();
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
