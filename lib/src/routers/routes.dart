import 'package:appetit/constants.dart';
import 'package:appetit/src/providers/auth_provider.dart';
import 'package:appetit/src/screens/auth/login/login_screen.dart';
import 'package:appetit/src/screens/auth/register/register_screen.dart';
import 'package:appetit/src/screens/auth/reset/reset_screen.dart';
import 'package:appetit/src/screens/states/error/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {

  // final AuthProvider authProvider;
  // AppRoutes(this.authProvider);

  final AuthProvider authProvider = AuthProvider();

  late final router = GoRouter(
    refreshListenable: authProvider,
    debugLogDiagnostics: true,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: homeRouteName,
        path: '/',
        redirect: (state) =>
        // TODO: Change to Home Route
          state.namedLocation(loginRouteName),
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
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: ErrorScreen(error: state.error),
    ),
  );
}