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

import 'AppAuth.dart';
import 'AppRouteName.dart';
import 'data/model/LoginRequest.dart';
import 'data/model/RegisterRequest.dart';
import 'screen/auth/ForeignPasswordScreen.dart';
import 'screen/auth/LoginScreen.dart';
import 'screen/auth/RegisterScreen.dart';
import 'screen/auth/VerifyCodeScreen.dart';
import 'screen/auth/WelcomeScreen.dart';
import 'screen/error/ErrorPage.dart';
import 'screen/events/EventCreateScreen.dart';
import 'screen/events/EventDetailsScreen.dart';
import 'screen/events/EventsScreen.dart';
import 'screen/setting/SettingsScreen.dart';
import 'screen/splash/SplashScreen.dart';
import 'screen/user/UserDetailsScreen.dart';

class AppRouter {
  final AppAuth appAuth;

  AppRouter({required this.appAuth});

  late final router = GoRouter(
    refreshListenable: appAuth,
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    routes: <GoRoute>[
      GoRoute(name: AppRouteName.root, path: '/', redirect: _redirectToEvents),
      GoRoute(name: AppRouteName.splash, path: '/splash', pageBuilder: _splashPage),
      GoRoute(name: AppRouteName.welcome, path: '/auth', pageBuilder: _welcomePage, routes: <GoRoute>[
        GoRoute(name: AppRouteName.login, path: 'login', pageBuilder: _loginPage),
        GoRoute(name: AppRouteName.register, path: 'register', pageBuilder: _registerPage),
        GoRoute(name: AppRouteName.foreignPassword, path: 'foreign-password', pageBuilder: _foreignPasswordPage),
        GoRoute(name: AppRouteName.verifyCode, path: 'verify-code', pageBuilder: _verifyCodePage),
      ]),
      GoRoute(name: AppRouteName.events, path: '/events', pageBuilder: _eventsPage, routes: <GoRoute>[
        GoRoute(name: AppRouteName.eventDetail, path: ':eventId', pageBuilder: _eventDetailsPage, routes: <GoRoute>[
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

  FutureOr<String?> _redirectToEvents(BuildContext context, GoRouterState state) {
    return '/events';
  }

  FutureOr<String?> _redirectToWelcome(BuildContext context, GoRouterState state) {
    return '/auth';
  }

  FadeTransitionPage _splashPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const SplashScreen(),
    );
  }

  FadeTransitionPage _welcomePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const WelcomeScreen(),
    );
  }

  FadeTransitionPage _loginPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: LoginScreen(
        onSignIn: (LoginRequest request) {
          appAuth.signIn(request.username, request.password);
        },
      ),
    );
  }

  FadeTransitionPage _registerPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: RegisterScreen(
        onSignUp: (RegisterRequest request) {
          appAuth.signUp(request.phone, request.username, request.password, request.verifyCode);
        },
      ),
    );
  }

  FadeTransitionPage _foreignPasswordPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const ForeignPasswordScreen(),
    );
  }

  FadeTransitionPage _verifyCodePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const VerifyCodeScreen(),
    );
  }

  FadeTransitionPage _eventsPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const EventsScreen(),
    );
  }

  FadeTransitionPage _eventDetailsPage(BuildContext context, GoRouterState state) {
    final eventId = int.parse(state.params['eventId']!);

    return FadeTransitionPage(
      key: state.pageKey,
      child: EventDetailsScreen(eventId: eventId),
    );
  }

  FadeTransitionPage _eventCreatePage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const EventCreateScreen(),
    );
  }

  FadeTransitionPage _userDetailsPage(BuildContext context, GoRouterState state) {
    final userId = int.parse(state.params['userId']!);

    return FadeTransitionPage(
      key: state.pageKey,
      child: UserDetailsScreen(userId: userId),
    );
  }

  FadeTransitionPage _settingsPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: const SettingsScreen(),
    );
  }

  FadeTransitionPage _errorPage(BuildContext context, GoRouterState state) {
    return FadeTransitionPage(
      key: state.pageKey,
      child: ErrorScreen(error: state.error),
    );
  }

  FutureOr<String?> _guard(BuildContext context, GoRouterState state) {
    final isAuthenticated = appAuth.authenticated;
    if (!isAuthenticated) {
      return _redirectToWelcome(context, state);
    }

    return null;
  }
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
  }) : super(
          key: key,
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: animation.drive(_curveTween),
              child: child,
            );
          },
          child: child,
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
