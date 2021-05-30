import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_desk_app/api/area_api.dart';
import 'package:help_desk_app/api/gerencia_api.dart';
import 'package:help_desk_app/api/nivel_usuario_api.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_state.dart';
import 'package:help_desk_app/bloc/provider_bloc.dart';
import 'package:help_desk_app/drawer_widget.dart';
import 'package:help_desk_app/pages/Equipos/equipos_page.dart';
import 'package:help_desk_app/pages/Mantenimiento/Area/area_page.dart';
import 'package:help_desk_app/bloc/bloc_cargando.dart';
import 'package:help_desk_app/pages/Mantenimiento/Errores/error_page.dart';
import 'package:help_desk_app/pages/Mantenimiento/Gerencia/gerencia_page.dart';
import 'package:help_desk_app/pages/Personas/registro_persona.dart';
import 'package:help_desk_app/pages/Usuarios/listar_usuarios.dart';
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
          initialRoute: 'home',
          routes: {
            "home": (BuildContext context) => MyHomePage(),
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

    final gerenciaApi =GerenciaApi();
    final areaApi =AreaApi();
    final nivelUsuarioApi=NivelUsuarioApi();

    gerenciaApi.listarGerencia();
    areaApi.listarAreas();
    nivelUsuarioApi.listarNivelesUsuario();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
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
              drawer: NavDrawerWidget("AskNilesh", "rathodnilsrk@gmail.com"),
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
        ));
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
            Text(' listar Usuario'),
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
              'Manteniento ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Errores ',
              style: TextStyle(
                fontSize: res.ip(2),
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
              'Manteniento ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Gerencia ',
              style: TextStyle(
                fontSize: res.ip(2),
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
              'Manteniento ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Areas ',
              style: TextStyle(
                fontSize: res.ip(2),
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
              'Manteniento ',
              style: TextStyle(
                fontSize: res.ip(2),
              ),
            ),
            Icon(Icons.chevron_right),
            Text(
              'Areas ',
              style: TextStyle(
                fontSize: res.ip(2),
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
      case NavItem.errores:
        return 'My Cart';

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
      case NavItem.errores:
        return Center(
          child: Text(
            'Errores',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
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
