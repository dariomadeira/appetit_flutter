import 'package:shared_preferences/shared_preferences.dart';

// CLASE PARA MANEJAR EL ALMACENAMIENTO LOCAL
class AppPreferences {

  // CONTRUCTOR FACTORY
  factory AppPreferences() {
    return _thisInstance;
  }  

  // DEVOLVBER SIEMPRE LA MISMA INSTANCIA
  AppPreferences._internal();

  // PATRÓN SINGLETON
  static final AppPreferences _thisInstance = AppPreferences._internal();
 
  // DECLARACIÓN
  late SharedPreferences _prefs;

  // CREAR INSTANCIA
  Future initPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // BORRAR TODAS LAS PREFERENCIAS
  void resetAll() {
    _prefs.clear();
  }

  // BORRAR PREFERENCIA ESPECIFICA
  void removePreference(String key) {
    _prefs.remove(key);
  }

  // LEER CADENA
  String readPreferenceString(String key) {
    return _prefs.getString(key) ?? "";
  }

  // GUARDAR CADENA
  void savePreferenceString(String key, String value) {
    _prefs.setString(key, value);
  }

  // LEER BOLEANO
  bool readPreferenceBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  // GUARDAR BOLEANO
  void savePreferenceBool(String key, bool value) {
    _prefs.setBool(key, value);
  }

  // GUARDAR LISTA DE CADENAS
  void saveListPreferenceString(String key, List<String> value) {
    _prefs.setStringList(key, value);
  }

  // LEER LISTA DE CADENAS
  List readListPreferenceString(String key) {
    return _prefs.getStringList(key)!;
  }
}
