class EquiposModel {
  String idEquipo;
  String idGerencia;
  String idArea;
  String equipoCodigo;
  String equipoNombre;
  String equipoIp;
  String equipoMac;

  String nombreGerencia;
  String nombreArea;

  EquiposModel({
    this.idEquipo,
    this.idGerencia,
    this.idArea,
    this.equipoCodigo,
    this.equipoNombre,
    this.equipoIp,
    this.equipoMac,
    this.nombreGerencia,
    this.nombreArea,
  });

  factory EquiposModel.fromJson(Map<String, dynamic> json) => EquiposModel(
        idEquipo: json["idEquipo"],
        idGerencia: json["idGerencia"],
        idArea: json["idArea"],
        equipoCodigo: json["equipoCodigo"],
        equipoNombre: json["equipoNombre"],
        equipoIp: json["equipoIp"],
        equipoMac: json["equipoMac"],
      );
}
