/// Extensión para capitalizar
extension CapExtension on String {

  /// Capitalizar la primera letra de la primera palabra
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';

  /// Convertir todo a mayúsculas
  String get allInCaps => toUpperCase();

  /// Capitalizar todas las primeras letras
  String get capitalizeFirstofEach => 
    split(' ').map((str) => 
      '${str[0].toUpperCase()}${str.substring(1)}').join(' ');
}