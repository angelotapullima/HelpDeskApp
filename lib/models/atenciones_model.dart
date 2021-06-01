class AtencionesModel {
  String idAtencion;
  String idSoporte;
  String horaRecepcion;
  String idResponsable;
  String gravedad;
  String horaReparacion;
  String idReceptorEquipo;
  String horaDevolucion;
  String estado;

  String nombreResponsable;
  String nombreRecoge;
  String problemaDetalle;

  AtencionesModel({
    this.idAtencion,
    this.idSoporte,
    this.horaRecepcion,
    this.idResponsable,
    this.gravedad,
    this.horaReparacion,
    this.idReceptorEquipo,
    this.horaDevolucion,
    this.estado,


    
    this.nombreResponsable,
    this.nombreRecoge,
    this.problemaDetalle,
  });

  factory AtencionesModel.fromJson(Map<String, dynamic> json) =>
      AtencionesModel(
        idAtencion: json["idAtencion"],
        idSoporte: json["idSoporte"],
        horaRecepcion: json["horaRecepcion"],
        idResponsable: json["idResponsable"],
        gravedad: json["gravedad"],
        horaReparacion: json["horaReparacion"],
        idReceptorEquipo: json["idReceptorEquipo"],
        horaDevolucion: json["horaDevolucion"],
        estado: json["estado"],
      );
}
