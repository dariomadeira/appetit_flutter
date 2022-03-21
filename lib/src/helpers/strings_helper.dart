import 'package:easy_localization/easy_localization.dart';

/// Clase para manejo de datos del usuario
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

  /// Localizar fecha a mostrar
  String localizeDateTime({DateTime? time}) {
    // final String _dayFormat = 'dd/MM/yyyy';
    // final String _timeFormat = 'HH:mm';
    // final String _hoursAbbreviation = 'Hs.';
    // final String _jointer = 'a las';
    // return Jiffy(time).format('$_dayFormat [$_jointer] $_timeFormat [$_hoursAbbreviation]');
    return time.toString();
  }

}