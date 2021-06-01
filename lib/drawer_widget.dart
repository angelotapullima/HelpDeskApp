import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_desk_app/bloc/blocDrawer/drawer_event.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_state.dart';
import 'package:help_desk_app/preferencias/preferencias_usuario.dart';
import 'package:help_desk_app/utils/responsive.dart';

class NavDrawerWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;

  final listGeneral = [
    _NavHeader(tipo: 1, listItem: [], nombre: ''),
    _NavHeader(
        tipo: 2,
        listItem: [
          _NavigationItem(false, NavItem.listarUsuario, "Listar",  FontAwesomeIcons.accusoft),
          _NavigationItem(
              false, NavItem.registarUsuarios, "reggistrar",  FontAwesomeIcons.accusoft),
        ],
        nombre: 'Usuarios'),
    _NavHeader(
        tipo: 2,
        listItem: [
          _NavigationItem(false, NavItem.errores, "Errores",  FontAwesomeIcons.accusoft),
          _NavigationItem(false, NavItem.gerencia, "Gerencia", FontAwesomeIcons.accusoft),
          _NavigationItem(false, NavItem.area, "Area",  FontAwesomeIcons.accusoft),
          _NavigationItem(
              false, NavItem.nivelUsuario, "Nivel de Usuario",  FontAwesomeIcons.accusoft),
        ],
        nombre: 'Mantenimiento'),
    _NavHeader(
        tipo: 2,
        listItem: [
          _NavigationItem(false, NavItem.gestion, "Gestión", FontAwesomeIcons.accusoft,),
        ],
        nombre: 'Equipos'),
    _NavHeader(
        tipo: 2,
        listItem: [
          _NavigationItem(false, NavItem.errorEquipos, "reportar error equipos",
              FontAwesomeIcons.accusoft),
        ],
        nombre: 'Soporte'),
    _NavHeader(
        tipo: 2,
        listItem: [
          _NavigationItem(false, NavItem.porAtender, "por Atender",  FontAwesomeIcons.accusoft),
          _NavigationItem(false, NavItem.enProcesoAtencion, "En proceso de atención",  FontAwesomeIcons.accusoft),
          _NavigationItem(false, NavItem.atencionesFinalizadas, "Atenciones Finalizadas",  FontAwesomeIcons.accusoft),
        ],
        nombre: 'Atenciones'),
    _NavHeader(
        tipo: 3,
        listItem: [
          //_NavigationItem(false, NavItem.atenciones, "Atenciones", Icons.home),
        ],
        nombre: 'Reportes'),
  ];

  NavDrawerWidget(this.accountName, this.accountEmail);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final preferences =Preferences();
    return Drawer(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: responsive.hp(5)),
          itemCount: listGeneral.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(
              context,
                listGeneral[index].tipo,
                listGeneral[index].listItem,
                listGeneral[index].nombre,
                responsive,preferences,);
          },
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context,int header, List<_NavigationItem> listItem, String nombre,
          Responsive res,Preferences preferences) =>
      (header == 1)
          ? _makeHeaderItem(res)
          : (header == 2)
              ? _listTitle(listItem, nombre, res)
              : Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: res.wp(5),
                  ),
                  child: MaterialButton(
                      color: Colors.red,
                      child: Text(
                        'Cerrar session',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        preferences.clearPreferences();
                       Navigator.pushNamedAndRemoveUntil(
                            context, 'login', (route) => false);
                      }),
                );

  Widget _makeHeaderItem(Responsive res) => UserAccountsDrawerHeader(
        accountName: Text(
          accountName,
          style: TextStyle(color: Colors.white),
        ),
        accountEmail: Text(
          accountEmail,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(color: Colors.indigo),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber,
          child: Icon(
            Icons.person,
            size: res.ip(4),
          ),
        ),
      );

  Widget _listTitle(
      List<_NavigationItem> listItem, String nombre, Responsive res) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        physics: ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index2) {
          if (index2 == 0) {
            return ListTile(
              title: Text(
                '$nombre',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: res.ip(1.8),
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.arrow_drop_down_circle_rounded,
                color: Colors.black,
                size: res.ip(3),
              ),
              //onTap: () => _handleItemClick(context, data.item),
            );
          }
          int index = index2 - 1;
          return BlocBuilder<NavDrawerBloc, NavDrawerState>(
            builder: (BuildContext context, NavDrawerState state) =>
                _makeListItem(listItem[index], state, res),
          );
        },
        itemCount: listItem.length + 1,
        shrinkWrap: true,
      ),
    );
  }

  Widget _makeListItem(
          _NavigationItem data, NavDrawerState state, Responsive res) =>
      Container(
        padding: EdgeInsets.only(left: res.wp(7)),
        child: Card(
          color: data.item == state.selectedItem
              ? Colors.blue.withOpacity(.6)
              : Colors.white,
          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
          borderOnForeground: true,
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Builder(
            builder: (BuildContext context) => ListTile(
              focusColor: Colors.blue,
              title: Text(
                data.title,
                style: TextStyle(
                  color: data.item == state.selectedItem
                      ? Colors.white
                      : Colors.blueGrey,
                ),
              ),
              leading: Icon(
                data.icon,
                color: data.item == state.selectedItem
                    ? Colors.white
                    : Colors.blueGrey,
              ),
              onTap: () => _handleItemClick(context, data.item),
            ),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final bool header;
  final NavItem item;
  final String title;
  final IconData icon;

  _NavigationItem(this.header, this.item, this.title, this.icon);
}

class _NavHeader {
  final int tipo;
  List<_NavigationItem> listItem;
  final String nombre;
  _NavHeader({this.tipo, this.listItem, this.nombre});
}
