import 'package:flutter/material.dart';
import 'package:help_desk_app/bloc/area_bloc.dart';
import 'package:help_desk_app/bloc/gerencia_bloc.dart';
import 'package:help_desk_app/bloc/nivel_usuario_bloc.dart';
import 'package:help_desk_app/bloc/persona_bloc.dart';
import 'package:help_desk_app/bloc/usuario_bloc.dart';

//singleton para obtner una unica instancia del Bloc
class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final gerenciaBloc = GerenciaBloc();
  final areaBloc = AreaBloc();
  final nivelUsuarioBloc = NivelUsuarioBloc();
  final personaBloc = PersonaBloc();
  final usuarioBloc = UsuarioBloc();

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static GerenciaBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .gerenciaBloc;
  }

  static AreaBloc area(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .areaBloc;
  }

  static NivelUsuarioBloc nivelU(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .nivelUsuarioBloc;
  }

  static PersonaBloc person(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .personaBloc;
  }

  static UsuarioBloc usuario(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>())
        .usuarioBloc;
  }
}
