


import 'package:help_desk_app/models/equipos_model.dart';

class AreaModel {
  String idArea;
  String idGerencia;
  String nombreGerencia;
  String nombreArea;

  List<EquiposModel>equipos;

  AreaModel({
    this.idArea,
    this.idGerencia,
    this.nombreGerencia,
    this.nombreArea,
    this.equipos
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      AreaModel(
        idArea: json["idArea"],
        idGerencia: json["idGerencia"],
        nombreArea: json["nombreArea"],
      );

}
