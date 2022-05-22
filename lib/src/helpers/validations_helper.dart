/// Clase para manejo de validaciones
class ValidationsHelper {

  /// Validar un email
  bool isValidEmail({String? value}) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value!);
  }

  /// Validar un password
  bool isValidPassword({String? value}) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value!);
  }

  /// Validar ambas contraseñas iguales
  bool isPasswordsSame({String? pass1 , String? pass2}) {
    return pass1 == pass2;
  }

  /// Validar teléfono
  bool isValidPhone({String? phone}) {
    String pattern = r'^(?:(?:00)?549?)?0?(?:11|[2368]\d)(?:(?=\d{0,2}15)\d{2})??\d{8}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phone!);
  }

}