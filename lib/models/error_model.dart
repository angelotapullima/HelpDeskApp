

class ErrorModel {
  String idError;
  String errorNombre;
  String errorTipo;

  ErrorModel({
    this.idError,
    this.errorNombre,
    this.errorTipo,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(
        idError: json["idError"],
        errorNombre: json["errorNombre"],
        errorTipo: json["errorTipo"],
      );

}
