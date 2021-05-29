


class AreaModel {
  String idArea;
  String idGerencia;
  String nombreGerencia;
  String nombreArea;

  AreaModel({
    this.idArea,
    this.idGerencia,
    this.nombreGerencia,
    this.nombreArea,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) =>
      AreaModel(
        idArea: json["idArea"],
        idGerencia: json["idGerencia"],
        nombreArea: json["nombreArea"],
      );

}
