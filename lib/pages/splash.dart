import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:help_desk_app/api/area_api.dart';
import 'package:help_desk_app/api/gerencia_api.dart';
import 'package:help_desk_app/api/nivel_usuario_api.dart';
import 'package:help_desk_app/api/person_api.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final gerenciaApi = GerenciaApi();
      final areaApi = AreaApi();
      final nivelUsuarioApi = NivelUsuarioApi();
      final personaAPi =PersonApi();

      final preferences = Preferences();

      if (preferences.estadoCargaInicial == null ||
          preferences.estadoCargaInicial == '0') {
        await gerenciaApi.listarGerencia();
        await areaApi.listarAreas();
        await nivelUsuarioApi.listarNivelesUsuario();
        await personaAPi.listarPersonas();

        preferences.estadoCargaInicial = '1';
      } else {
        gerenciaApi.listarGerencia();
        areaApi.listarAreas();
        nivelUsuarioApi.listarNivelesUsuario();
        personaAPi.listarPersonas();
      }

      if (preferences.idUsuario == "" || preferences.idUsuario == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'splash',
          child: FlutterLogo(
            size: responsive.ip(20),
          ),
        ),
      ), /* Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/fondo3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(.5),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(3),
              ),
              child: Image(
                  image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
            ),
          ),
          Center(
            child: CupertinoActivityIndicator(),
          ),
        ],
      ),
     */
    );
  }
}
