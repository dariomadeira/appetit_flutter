import 'package:appetit/constants.dart';
import 'package:appetit/src/screens/auth/login/login_screen.dart';
import 'package:appetit/src/screens/auth/register/register_screen.dart';
import 'package:appetit/src/screens/auth/reset/reset_screen.dart';
import 'package:appetit/src/screens/home/home_screen.dart';
import 'package:appetit/src/screens/onboarding/onboarding_screen.dart';
import 'package:appetit/src/screens/states/error/error_screen.dart';
import 'package:appetit/src/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  late final AppService appService;
  AppRoutes(this.appService);

  late final router = GoRouter(
    refreshListenable: appService,
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
      // Si esta logueado segun el provider
      final loggedIn = appService.isloggedUser;
      // Si ha visto el onboarding
      final seeOnboarding = appService.showOnboarding;
      // Si esta en el screen de login
      final loginLoc = state.namedLocation(loginRouteName);
      final inLoginScreen = state.subloc == loginLoc; // nos dice si esta en la login screen
      // Si esta en el screen de register
      final registerLoc = state.namedLocation(registerRouteName);
      final inRegisterScreen = state.subloc == registerLoc; // nos dice si esta en la register screen
      // Si esta en el screen de reset
      final resetLoc = state.namedLocation(resetRouteName);
      final inResetScreen = state.subloc == resetLoc; // nos dice si esta en la reset screen
      // Si esta en el screen de onboarding
      final onboardingLoc = state.namedLocation(onboardingRouteName);
      final inOnboardingScreen = state.subloc == onboardingLoc; // nos dice si esta en la reset screen
      // ruta del root
      final rootLoc = state.namedLocation(rootRouteName);
      // lógica de que mostrar
      if (!loggedIn && !inLoginScreen && !inRegisterScreen && !inResetScreen && !inOnboardingScreen) {
        if (seeOnboarding) {
          return loginLoc;
        } else {
          return onboardingLoc;
        }
      }
      if (loggedIn && (inLoginScreen || inRegisterScreen || inResetScreen || inOnboardingScreen)) {
        return rootLoc;
      }
      return null;
    },

  );
}