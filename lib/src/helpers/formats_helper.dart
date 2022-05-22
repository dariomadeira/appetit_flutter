/// Clase para manejo de formatos
class FormatsHelper {

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