class PersonModel {
  String idPerson;
  String dni;
  String nombre;
  String apellido;
  String idGerencia;
  String idArea;
  String nivelUsuario;
  String nombreGerencia;
  String nombreArea;
  String nombreNivelUsuario;

  PersonModel({
    this.idPerson,
    this.dni,
    this.nombre,
    this.apellido,
    this.idGerencia,
    this.idArea,
    this.nivelUsuario,
    this.nombreGerencia,
    this.nombreArea,
    this.nombreNivelUsuario,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) =>
      PersonModel(
        idPerson: json["idPerson"],
        dni: json["dni"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        idGerencia: json["idGerencia"],
        idArea: json["idArea"],
        nivelUsuario: json["nivelUsuario"],
      );

}
