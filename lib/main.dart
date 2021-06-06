import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_state.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/drawer_widget.dart';
import 'package:help_desk_app/pages/Atenciones/atenciones_finalizadas.dart';
import 'package:help_desk_app/pages/Atenciones/por_atender.dart';
import 'package:help_desk_app/pages/Atenciones/proceso_de_atencion.dart';
import 'package:help_desk_app/pages/Equipos/equipos_page.dart';
import 'package:help_desk_app/pages/Mantenimiento/Area/area_page.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/pages/Mantenimiento/Errores/error_page.dart';
import 'package:help_desk_app/pages/Mantenimiento/Gerencia/gerencia_page.dart';
import 'package:help_desk_app/pages/Personas/registro_persona.dart';
import 'package:help_desk_app/pages/Usuarios/listar_usuarios.dart';
import 'package:help_desk_app/pages/loginPage.dart';
import 'package:help_desk_app/pages/soporte/errores_equipos.dart';
import 'package:help_desk_app/pages/splash.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';
import 'package:provider/provider.dart';

import 'pages/Mantenimiento/NivelUsuario/nivel_usuario_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new Preferences();

  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlocCargando>(
          create: (_) => BlocCargando(),
        ),
      ],
      child: ProviderBloc(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Navigation Drawer Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white),
          initialRoute: 'splash',
          routes: {
            "home": (BuildContext context) => MyHomePage(),
            "login": (BuildContext context) => LoginPage(),
            "splash": (BuildContext context) => Splash(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NavDrawerBloc _bloc;
  Widget _content;

  @override
  void initState() {
    super.initState();
    _bloc = NavDrawerBloc(NavDrawerState(NavItem.listarUsuario));
    _content = _getContentForState(_bloc.state.selectedItem);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final preferences = Preferences();
    return BlocProvider<NavDrawerBloc>(
      create: (BuildContext context) => _bloc,
      child: BlocListener<NavDrawerBloc, NavDrawerState>(
        listener: (BuildContext context, NavDrawerState state) {
          setState(() {
            _content = _getContentForState(state.selectedItem);
          });
        },
        child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
          builder: (BuildContext context, NavDrawerState state) => Scaffold(
            drawer: NavDrawerWidget(
                "${preferences.personaNombre} ${preferences.personaApellido}",
                "${preferences.userEmail}"),
            appBar: AppBar(
              title: _getAppbarTitle(state.selectedItem, responsive),
              centerTitle: false,
              brightness: Brightness.light,
            ),
            body: AnimatedSwitcher(
              switchInCurve: Curves.easeInExpo,
              switchOutCurve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 300),
              child: _content,
            ),
          ),
        ),
      ),
    );
  }

  _getAppbarTitle(NavItem state, Responsive res) {
    switch (state) {
      case NavItem.listarUsuario:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text('Home'),
            Icon(Icons.chevron_right),
            Text(' Listar Usuario'),
          ],
        );
      case NavItem.registarUsuarios:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Usuarios ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Registro Persona ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
          ],
        );
      case NavItem.errores:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Mantenimiento ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Errores ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
          ],
        );

      case NavItem.gerencia:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Mantenimiento ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Gerencia ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
          ],
        );
      case NavItem.area:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Mantenimiento ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Áreas ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
          ],
        );
      case NavItem.nivelUsuario:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Mantenimiento ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Nivel usuario ',
              style: TextStyle(
                fontSize: res.ip(1.7),
              ),
            ),
          ],
        );
      case NavItem.gestion:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Equipos ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Gestión ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
          ],
        );
      case NavItem.errorEquipos:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Soporte ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Equipos ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
          ],
        );
      case NavItem.porAtender:
        return Row(
          children: [
            SizedBox(
              width: res.wp(2),
            ),
            Text(
              'Atenciones ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'pendientes de atención ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
          ],
        );
      case NavItem.enProcesoAtencion:
        return Row(
          children: [
            Text(
              'Atenciones ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'En proceso de atención ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
          ],
        );
      case NavItem.atencionesFinalizadas:
        return Row(
          children: [
            Text(
              'Atenciones ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Atenciones Finalizadas ',
              style: TextStyle(
                fontSize: res.ip(1.5),
              ),
            ),
          ],
        );

      default:
        return '';
    }
  }

  _getContentForState(NavItem state) {
    switch (state) {
      case NavItem.listarUsuario:
        return ListarUsuarios();
      case NavItem.registarUsuarios:
        return RegistroPersona();
      case NavItem.errores:
        return ErrorPage();
      case NavItem.gerencia:
        return GerenciaPage();
      case NavItem.area:
        return AreaPage();
      case NavItem.nivelUsuario:
        return NivelUsuarioPage();

      case NavItem.gestion:
        return ListarEquipos();
      case NavItem.errorEquipos:
        return ErroresEquipos();
      case NavItem.porAtender:
        return AtencionesPage();
      case NavItem.enProcesoAtencion:
        return ProcesoDeAtencion();
      case NavItem.atencionesFinalizadas:
        return AtencionesFinalizadas();
      default:
        return Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}
