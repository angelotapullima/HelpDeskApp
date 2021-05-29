import 'package:flutter/material.dart';
import 'package:help_desk_app/api/usuario_api.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/models/Usuario_model.dart';
import 'package:help_desk_app/models/person_model.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

class EditarUsario extends StatefulWidget {
  const EditarUsario({Key key, @required this.usuario}) : super(key: key);

  final UsuarioModel usuario;

  @override
  _EditarUsarioState createState() => _EditarUsarioState();
}

class _EditarUsarioState extends State<EditarUsario> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _telefonoController = new TextEditingController();

  //datos Person
  String dropdownPerson = '';
  List<String> listPersom = [];
  int cantItemsPersom = 0;
  String idPerson = 'Seleccionar';

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  final keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final provider = Provider.of<BlocCargando>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuario'),
      ),
      body: ValueListenableBuilder(
          valueListenable: provider.cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.wp(5),
                  ),
                  child: Form(
                    key: keyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(0),
                          ),
                          child: Text(
                            'Datos Actuales',
                            style: TextStyle(
                                fontSize: responsive.ip(2),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Usuario :',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${widget.usuario.user}',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Email :',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${widget.usuario.email}',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Teléfono :',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${widget.usuario.telefono}',
                                style: TextStyle(
                                    fontSize: responsive.ip(1.6),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(5),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsive.wp(0),
                          ),
                          child: Text(
                            'Actualizar Datos',
                            style: TextStyle(
                                fontSize: responsive.ip(2),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Divider(),
                        Text(
                          'Usuario ',
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
                                hintText: 'Usuario'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'El campo no debe estar vacio';
                              } else {
                                return null;
                              }
                            },
                            enableInteractiveSelection: false,
                            controller: _userController,
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(2),
                        ),
                        Text(
                          'Contraseña ',
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
                                hintText: 'Contraseña'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'El campo no debe estar vacio';
                              } else {
                                return null;
                              }
                            },
                            enableInteractiveSelection: false,
                            controller: _passController,
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        Text(
                          'Email ',
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
                                hintText: 'Email'),
                            validator: (value) {
                              if (value.isNotEmpty) { 
                                return null;
                              } else {
                                return 'El campo no debe estar vacio';
                              }
                            },
                            enableInteractiveSelection: false,
                            controller: _emailController,
                          ),
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        Text(
                          'Teléfono ',
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
                                hintText: 'Teléfono'),
                            validator: (value) {
                              if (value.isNotEmpty) {
                                if (value.length < 8) {
                                  return 'Se debe ingresar más de 8 dígitos ';
                                }
                                return null;
                              } else {
                                return 'El campo no debe estar vacio';
                              }
                            },
                            enableInteractiveSelection: false,
                            controller: _telefonoController,
                          ),
                        ),
                         
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        SizedBox(
                          height: responsive.hp(1),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            MaterialButton(
                              color: Colors.blue,
                              child: Text(
                                'Registrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.ip(2),
                                ),
                              ),
                              onPressed: () async {
                                if (keyForm.currentState.validate()) { 
                                    final usuarioBloc =
                                        ProviderBloc.usuario(context);

                                    final usuarioApi = UsuarioApi();

                                    UsuarioModel usuarioModel = UsuarioModel();
                                    usuarioModel.idUsuario = widget.usuario.idUsuario;
                                    usuarioModel.dni = widget.usuario.dni;
                                    usuarioModel.user = _userController.text;
                                    usuarioModel.pass = _passController.text;
                                    usuarioModel.email = _emailController.text;
                                    usuarioModel.telefono =
                                        _telefonoController.text;

                                    provider.setValor(true);
                                    final res = await usuarioApi
                                        .editarUsuario(usuarioModel);

                                    provider.setValor(false);

                                    if (res == 1) {
                                      registroCorrecto('Registro completo');
                                    } else if (res == 2) {
                                      registroCorrecto('Registro fallido');
                                    } else if (res == 3) {
                                      registroCorrecto(
                                          'Persona con Dni ya existe');
                                    } else if (res == 4) {
                                      registroCorrecto(
                                          'el dni no tiene 8 Carácteres');
                                    }

                                    _userController.text = '';
                                    _passController.text = '';
                                    _emailController.text = '';
                                    _telefonoController.text = '';
                                    dropdownPerson = 'Seleccionar';
                                    usuarioBloc.obtenerUsuarios();
                                   
                                }
                              },
                            )
                          ],
                        )
                      ],
                    ),
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
