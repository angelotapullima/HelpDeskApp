class UsuarioModel {
  String idUsuario;
  String dni;
  String user;
  String pass;
  String email;
  String telefono;
  String nombrePerson;
  String gerenciaNombre;
  String areaNombre;

  UsuarioModel({
    this.idUsuario,
    this.dni,
    this.user,
    this.pass,
    this.email,
    this.telefono,
    this.nombrePerson,
    this.gerenciaNombre,
    this.areaNombre,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuario: json["idUsuario"],
        dni: json["dni"],
        user: json["user"],
        pass: json["pass"],
        email: json["email"],
        telefono: json["telefono"],
      );
}
