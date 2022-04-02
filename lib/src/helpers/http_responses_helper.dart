
/// Clase para manejar las respuestas Http
class HttpResponses {

  /// Datos que retorna
  final dynamic data;
  /// Error que retorna
  final HttpErros error;

  /// Constructor
  HttpResponses(
    this.data,
    this.error
  );

  /// Consulta exitosa
  static HttpResponses success(
    dynamic data
  ) => HttpResponses(data, HttpErros(statusCode: 200, message: "", data: ""));

  /// Error en la consulta
  static HttpResponses fail({
    required int statusCode,
    required String message,
    required dynamic data,
  }) => HttpResponses(null, HttpErros(statusCode: statusCode, message: message, data: data));
}

/// Clase para el manejo del error
class HttpErros {

  /// Código de error
  final int statusCode;
  /// Mensaje de error
  final String message;
  /// Datos obtenidos
  final dynamic data;

  /// Constructor
  HttpErros({
    required this.statusCode,
    required this.message,
    required this.data
  });

}
