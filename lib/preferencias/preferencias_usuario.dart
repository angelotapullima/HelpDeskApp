

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {


  static final Preferences _instancia = new Preferences._internal();

  factory Preferences(){
    return _instancia;
  }

  SharedPreferences _prefs ;

  Preferences._internal();

  initPrefs()async {
    
    this._prefs = await SharedPreferences.getInstance() ;

  }

  clearPreferences()async{
    await  _prefs.clear();
  }


  get estadoCargaInicial{
    return _prefs.getString('estadoCarga');
  }

  set estadoCargaInicial(String value){

    _prefs.setString('estadoCarga', value);
  }



  get idUsuario {
    return _prefs.getString('id_usuario');
  }

  set idUsuario(String value) {
    _prefs.setString('id_usuario', value);
  }

  get idPersona{
    _prefs.getString('id_persona');
  }

  set idPersona(String value) {
    _prefs.setString('id_persona', value);
  }

  get userNickname {
    return _prefs.getString('usuario_nick');
  }

  set userNickname(String value) {
    _prefs.setString('usuario_nick', value);
  }

  get userEmail {
    return _prefs.getString('usuario_email');
  }

  set userEmail(String value) {
    _prefs.setString('usuario_email', value);
  }

  get usuarioTelefono {
    return _prefs.getString('usuario_telefono');
  }

  set usuarioTelefono(String value) {
    _prefs.setString('usuario_telefono', value);
  }

  get usuarioEstado {
    return _prefs.getString('usuario_estado');
  }

  set usuarioEstado(String value) {
    _prefs.setString('usuario_estado', value);
  }

  get idGerencia {
    return _prefs.getString('id_gerencia');
  }

  set idGerencia(String value) {
    _prefs.setString('id_gerencia', value);
  }

  get idNivel {
    return _prefs.getString('id_nivel');
  }

  set idNivel(String value) {
    _prefs.setString('id_nivel', value);
  }

  get idArea {
    return _prefs.getString('id_area');
  }

  set idArea(String value) {
    _prefs.setString('id_area', value);
  }

  get personDni {
    return _prefs.getString('persona_dni');
  }

  set personDni(String value) {
    _prefs.setString('persona_dni', value);
  }


  get personaNombre {
    return _prefs.getString('persona_nombre');
  }

  set personaNombre(String value) {
    _prefs.setString('persona_nombre', value);
  }

  get personaApellido {
    return _prefs.getString('persona_apellido');
  }

  set personaApellido(String value) {
    _prefs.setString('persona_apellido', value);
  }

  get personaEstado {
    return _prefs.getString('persona_estado');
  }

  set personaEstado(String value) {
    _prefs.setString('persona_estado', value);
  }
}