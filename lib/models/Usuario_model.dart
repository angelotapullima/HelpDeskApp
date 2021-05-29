class UsuarioModel {
  String idPerson;
  String user;
  String pass;
  String email;
  String telefono;
  String nombrePerson;
  String gerenciaNombre;
  String areaNombre;

  UsuarioModel({
    this.idPerson,
    this.user,
    this.pass,
    this.email,
    this.telefono,
    this.nombrePerson,
    this.gerenciaNombre,
    this.areaNombre,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idPerson: json["idPerson"],
        user: json["user"],
        pass: json["pass"],
        email: json["email"],
        telefono: json["telefono"],
      );
}
