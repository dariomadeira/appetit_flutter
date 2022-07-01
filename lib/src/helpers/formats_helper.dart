import 'package:easy_localization/easy_localization.dart';
// import 'package:intl/intl.dart';

// CLASE PARA MANEJO DE FORMATOS
class FormatsHelper {

  // LOCALIZAR UNA FECHA PARA MOSTRAR
  String localizeDateTime({
    String? dateString
  }) {
    // final String _dayFormat = 'dd/MM/yyyy';
    // final String _timeFormat = 'HH:mm';
    // final String _hoursAbbreviation = 'Hs.';
    // final String _jointer = 'a las';
    // return Jiffy(time).format('$_dayFormat [$_jointer] $_timeFormat [$_hoursAbbreviation]');
    String _formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(dateString!));
    String _formattedTime = dateTimeFormatter(dateString);
    return "${_formattedDate} " + tr("general_at_conector") +" ${_formattedTime} " + tr("general_hs");
  }

  // FORMATEADOR CON HORA LOCAL UTC
  String dateTimeFormatter(String dateTime, {String? format}) {
  return DateFormat(format ?? 'HH:mm')
      .format(DateTime.parse(dateTime).toLocal())
      .toString();
  }

}