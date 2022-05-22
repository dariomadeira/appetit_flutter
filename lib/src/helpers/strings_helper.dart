import 'package:easy_localization/easy_localization.dart';

/// Clase para manejo de strings
class StringsHelper {

  /// Obtener las iniciales del nombre de una persona
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