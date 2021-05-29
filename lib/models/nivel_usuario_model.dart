class NivelUsuarioModel {
  String idNivel;
  String nombreNivel;

  NivelUsuarioModel({
    this.idNivel,
    this.nombreNivel,
  });

  factory NivelUsuarioModel.fromJson(Map<String, dynamic> json) =>
      NivelUsuarioModel(
        idNivel: json["idNivel"],
        nombreNivel: json["nombreNivel"],
      );
}
