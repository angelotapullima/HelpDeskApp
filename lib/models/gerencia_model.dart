





import 'package:help_desk_app/models/area_model.dart';

class GerenciaModel {
  String idGerencia;
  String nombreGerencia;

  List<AreaModel> areas;

  GerenciaModel({
    this.idGerencia,
    this.nombreGerencia,
    this.areas
  });

  factory GerenciaModel.fromJson(Map<String, dynamic> json) =>
      GerenciaModel(
        idGerencia: json["idGerencia"],
        nombreGerencia: json["nombreGerencia"],
      );

}
