class FallasModel {
  String idFalla;
  String idSolicitante;
  String nombreSolicitante;
  String idEquipo;
  String nombreEquipo;
  String idError;
  String nombreError;
  String otroError;
  String nombreOtroError;
  String fecha;
  String hora;
  String detalleError;
  String estado;

  FallasModel({
    this.idFalla,
    this.idSolicitante,
    this.nombreSolicitante,
    this.idEquipo,
    this.nombreEquipo,
    this.idError,
    this.nombreError,
    this.otroError,
    this.nombreOtroError,
    this.fecha,
    this.hora,
    this.detalleError,
    this.estado,
  });

  factory FallasModel.fromJson(Map<String, dynamic> json) => FallasModel(
        idFalla: json["idFalla"],
        idSolicitante: json["idSolicitante"],
        nombreSolicitante: json["nombreSolicitante"],
        idEquipo: json["idEquipo"],
        nombreEquipo: json["nombreEquipo"],
        idError: json["idError"],
        otroError: json["otroError"],
        fecha: json["fecha"],
        hora: json["hora"],
        detalleError: json["detalleError"],
        estado: json["estado"],
      );
}
