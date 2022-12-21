/*
 * Copyright 2022 Pavel Suprunov
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride2online/src/util/FadeTransitionPage.dart';

import 'AppRouteName.dart';
import 'screen/auth/WelcomeScreen.dart';
import 'screen/auth/login/ChangePasswordScreen.dart';
import 'screen/auth/login/ForeignPasswordScreen.dart';
import 'screen/auth/login/LoginScreen.dart';
import 'screen/auth/login/LoginVerifyCodeScreen.dart';
import 'screen/auth/register/RegisterScreen.dart';
import 'screen/auth/register/RegisterVerifyCodeScreen.dart';
import 'screen/error/ErrorPage.dart';
import 'screen/events/EventCreateScreen.dart';
import 'screen/events/EventDetailsScreen.dart';
import 'screen/events/EventsScreen.dart';
import 'screen/setting/SettingsScreen.dart';
import 'screen/splash/SplashScreen.dart';
import 'screen/user/UserDetailsScreen.dart';
import 'service/AuthService.dart';

class AppRouter {
  final AuthService auth;

  AppRouter({required this.auth});

  late final router = GoRouter(
    refreshListenable: auth,
    debugLogDiagnostics: true,
    initialLocation: _redirectToSplash(),
    routes: [
      GoRoute(name: AppRouteName.root, path: '/', redirect: _redirectToEvents),
      GoRoute(name: AppRouteName.splash, path: '/splash', pageBuilder: _splashPage),
      GoRoute(name: AppRouteName.welcome, path: '/auth', pageBuilder: _welcomePage, routes: [
        GoRoute(name: AppRouteName.login, path: 'login', pageBuilder: _loginPage, routes: [
          GoRoute(name: AppRouteName.foreignPassword, path: 'foreign-password', pageBuilder: _foreignPasswordPage),
          GoRoute(name: AppRouteName.loginVerifyCode, path: 'login-verify-code', pageBuilder: _loginVerifyCodePage),
          GoRoute(name: AppRouteName.changePassword, path: 'change-password', pageBuilder: _changePasswordPage),
        ]),
        GoRoute(name: AppRouteName.register, path: 'register', pageBuilder: _registerPage, routes: [
          GoRoute(name: AppRouteName.registerVerifyCode, path: 'register-verify-code', pageBuilder: _registerVerifyCodePage),
        ]),
      ]),
      GoRoute(name: AppRouteName.events, path: '/events', pageBuilder: _eventsPage, routes: [
        GoRoute(name: AppRouteName.eventDetail, path: ':eventId', pageBuilder: _eventDetailsPage, routes: [
          GoRoute(name: AppRouteName.eventEdit, path: 'edit', pageBuilder: _eventCreatePage),
        ]),
        GoRoute(name: AppRouteName.eventCreate, path: 'create', pageBuilder: _eventCreatePage),
      ]),
      GoRoute(name: AppRouteName.userDetail, path: '/user/:userId', pageBuilder: _userDetailsPage),
      GoRoute(name: AppRouteName.settings, path: '/settings', pageBuilder: _settingsPage),
    ],
    errorPageBuilder: _errorPage,
    redirect: _guard,
  );

  String _redirectToSplash() {
    return '/splash';
  }

  String _redirectToEvents(BuildContext context, GoRouterState state) {
    return '/events';
  }

  String _redirectToWelcome(BuildContext context, GoRouterState state) {
    return '/auth';
  }

  FadeTransitionPage _splashPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const SplashScreen());
  }

  FadeTransitionPage _welcomePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const WelcomeScreen());
  }

  FadeTransitionPage _loginPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const LoginScreen());
  }

  FadeTransitionPage _foreignPasswordPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const ForeignPasswordScreen());
  }

  FadeTransitionPage _changePasswordPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const ChangePasswordScreen());
  }

  FadeTransitionPage _loginVerifyCodePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const LoginVerifyCodeScreen());
  }

  FadeTransitionPage _registerPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const RegisterScreen());
  }

  FadeTransitionPage _registerVerifyCodePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const RegisterVerifyCodeScreen());
  }

  FadeTransitionPage _eventsPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const EventsScreen());
  }

  FadeTransitionPage _eventDetailsPage(BuildContext context, GoRouterState state) {
    final eventId = int.parse(state.params['eventId']!);

    return FadeTransitionPage(key: state.pageKey, child: EventDetailsScreen(eventId: eventId));
  }

  FadeTransitionPage _eventCreatePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const EventCreateScreen());
  }

  FadeTransitionPage _userDetailsPage(BuildContext context, GoRouterState state) {
    final userId = int.parse(state.params['userId']!);

    return FadeTransitionPage(key: state.pageKey, child: UserDetailsScreen(userId: userId));
  }

  FadeTransitionPage _settingsPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: const SettingsScreen());
  }

  FadeTransitionPage _errorPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(key: state.pageKey, child: ErrorScreen(error: state.error));
  }

  FutureOr<String?> _guard(BuildContext context, GoRouterState state) {
    final routeSubLocation = state.subloc;
    final isAuthScreen = routeSubLocation.contains(_redirectToWelcome(context, state));
    final isAuthenticated = auth.authenticated;

    if (routeSubLocation == _redirectToSplash()) return null;
    if (!isAuthenticated && !isAuthScreen) return _redirectToWelcome(context, state);
    if (isAuthenticated && isAuthScreen) return _redirectToEvents(context, state);

    return null;
  }
}
