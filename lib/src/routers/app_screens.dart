import 'package:flutter/material.dart';
import 'package:appetit/src/screens/home/home_screen.dart';

/// MANEJADOR DE RUTAS
final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => HomeScreen(),
};
