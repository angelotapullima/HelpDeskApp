





class GerenciaModel {
  String idGerencia;
  String nombreGerencia;

  GerenciaModel({
    this.idGerencia,
    this.nombreGerencia,
  });

  factory GerenciaModel.fromJson(Map<String, dynamic> json) =>
      GerenciaModel(
        idGerencia: json["idGerencia"],
        nombreGerencia: json["nombreGerencia"],
      );

}
