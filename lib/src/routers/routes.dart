
import 'package:appetit/src/screens/auth/login/login_screen.dart';
import 'package:appetit/src/screens/auth/register/register_screen.dart';
import 'package:appetit/src/screens/auth/reset/reset_screen.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:appetit/src/screens/home/home_screen.dart';

/// MANEJADOR DE RUTAS
final Map<String, Widget Function(BuildContext)> appRoutes = {
  'home': (_) => HomeScreen(),
  'login': (_) => LoginScreen(),
  'onboarding': (_) => OnboardingScreen(),
  'register': (_) => RegisterScreen(),
  'reset': (_) => ResetScreen(),
};

// '/': (context) => ChangeNotifierProvider<MyModel>(
//   create: (_) => MyModel(),
//   child: MyScreen()),
