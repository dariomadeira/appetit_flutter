import 'package:easy_localization/easy_localization.dart';

// CLASE PARA MANEJO DE STRINGS
class StringsHelper {

  // OBTENER LAS INICIALES DE UN NOMBRE
  String getInicials ({
    String? name,
  }) {
    String _result = tr('general_question');
    if (name != null) {
      final arrayName = name.split(' ');
      final int countCharacters = arrayName.length;
      if (countCharacters > 1) {
        _result = name[0] + arrayName[countCharacters-1][0];
      }
    }
    return _result;
  }

}