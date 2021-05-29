import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/drawer_event.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_bloc.dart';
import 'package:help_desk_app/bloc/blocDrawer/nav_drawer_state.dart'; 
import 'package:help_desk_app/utils/responsive.dart';

class NavDrawerWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;

  final listGeneral = [
    _NavHeader(header: true, listItem: [], nombre: ''),
    _NavHeader(
        header: false,
        listItem: [
          _NavigationItem(false, NavItem.listarUsuario, "Listar", Icons.home),
          _NavigationItem(
              false, NavItem.registarUsuarios, "reggistrar", Icons.person),
        ],
        nombre: 'Usuarios'),
    _NavHeader(
        header: false,
        listItem: [
          _NavigationItem(false, NavItem.errores, "Errores", Icons.home),
          _NavigationItem(false, NavItem.gerencia, "Gerencia", Icons.person),
          _NavigationItem(false, NavItem.area, "Area", Icons.person),
          _NavigationItem(false, NavItem.nivelUsuario, "Nivel de Usuario", Icons.person),
        ],
        nombre: 'Mantenimiento'),
    _NavHeader(
        header: false,
        listItem: [
          _NavigationItem(false, NavItem.gestion, "Gestion", Icons.home),
        ],
        nombre: 'Equipos'),
    _NavHeader(
        header: false,
        listItem: [
          _NavigationItem(false, NavItem.reportes, "Reportes", Icons.home),
        ],
        nombre: 'Reportes'),
  ];

  NavDrawerWidget(this.accountName, this.accountEmail);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Drawer(
      child: Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: listGeneral.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(
                listGeneral[index].header,
                listGeneral[index].listItem,
                listGeneral[index].nombre,
                responsive);
          },
        ),
      ),
    );
  }

  Widget _buildItem(bool header, List<_NavigationItem> listItem, String nombre,
          Responsive res) =>
      header ? _makeHeaderItem(res) : _listTitle(listItem, nombre, res);

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
          color: data.item == state.selectedItem?Colors.blue.withOpacity(.6):Colors.white,
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
  final bool header;
  List<_NavigationItem> listItem;
  final String nombre;
  _NavHeader({this.header, this.listItem, this.nombre});
}
