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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ride2online/src/data/AppContainerImpl.dart';

import 'Router.dart';
import 'screen/auth/LoginScreen.dart';
import 'screen/splash/SplashScreen.dart';
import 'service/AuthViewModel.dart';
import 'theme/AppThemeDark.dart';
import 'theme/AppThemeLight.dart';

class App extends StatelessWidget {
  late final AuthService _authService;

  App({required AppContainerImpl appContainer, super.key}) {
    _authService = AuthService(appContainer.getAuthRepository());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _authService),
      ],
      child: MaterialApp.router(
        title: 'Moto events',
        theme: AppThemeLight().toThemeData(),
        darkTheme: AppThemeDark().toThemeData(),
        themeMode: ThemeMode.system,
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              name: RouteDefine.splash.name,
              path: '/',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: const SplashScreen(),
              ),
            ),
            GoRoute(
              name: RouteDefine.login.name,
              path: '/login',
              pageBuilder: (context, state) => MaterialPage<void>(
                key: state.pageKey,
                child: LoginScreen(),
              ),
            ),
          ],
          redirect: (BuildContext context, GoRouterState state) {
            final authenticated = _authService.authenticated;
            final goingToLogin = (state.name == RouteDefine.login.name);

            // the user is not logged in and not headed to /login, they need to login
            if (!authenticated && !goingToLogin) return context.namedLocation(RouteDefine.login.name);

            // the user is logged in and headed to /login, no need to login again
            if (authenticated && goingToLogin) return context.namedLocation(RouteDefine.events.name);

            // no need to redirect at all
            return null;
          },
        ),
      ),
    );
  }
}
