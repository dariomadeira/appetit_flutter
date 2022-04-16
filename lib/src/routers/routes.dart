import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/screens/auth/login/login_screen.dart';
import 'package:appetit/src/screens/auth/register/register_screen.dart';
import 'package:appetit/src/screens/auth/reset/reset_screen.dart';
import 'package:appetit/src/screens/home/home_screen.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:appetit/src/screens/states/error/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  final _authProvider = AuthProvider();

  late final router = GoRouter(
    // initialLocation: '/',
    refreshListenable: _authProvider,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) => state.namedLocation(homeRouteName),
      ),
      GoRoute(
        name: loginRouteName,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        name: registerRouteName,
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        name: resetRouteName,
        path: '/reset',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: ResetScreen(),
        ),
      ),
      GoRoute(
        name: onboardingRouteName,
        path: '/onboarding',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        name: homeRouteName,
        path: '/home',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: HomeScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorScreen(error: state.error),
    ),
    redirect: (state) {
      /// Si esta logueado segun el provider
      final loggedIn = _authProvider.loggedIn;

      // Si esta en el screen de login
      final loginLoc = state.namedLocation(loginRouteName);
      final inLoginScreen = state.subloc == loginLoc; // no dice si esta en la login screen

      // Si esta en el screen de register
      final registerLoc = state.namedLocation(registerRouteName);
      final inRegisterScreen = state.subloc == registerLoc; // no dice si esta en la register screen

      // Si esta en el screen de reset
      final resetLoc = state.namedLocation(resetRouteName);
      final inResetScreen = state.subloc == resetLoc; // no dice si esta en la reset screen

      // Si esta en el screen de onboarding
      final onboardingLoc = state.namedLocation(onboardingRouteName);
      final inOnboardingScreen = state.subloc == onboardingLoc; // no dice si esta en la reset screen

      // ruta del root
      final rootLoc = state.namedLocation(rootRouteName);

      if (!loggedIn && !inLoginScreen && !inRegisterScreen && !inResetScreen && !inOnboardingScreen) {
        return loginLoc;
      }
      if (loggedIn && (inLoginScreen || inRegisterScreen || inResetScreen || inOnboardingScreen)) {
        return rootLoc;
      }
      return null;
    },

  );
}