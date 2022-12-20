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
import 'package:ride2online/src/data/AppContainer.dart';

import 'AppAuth.dart';
import 'AppRouter.dart';
import 'screen/splash/SplashScreen.dart';
import 'theme/AppThemeDark.dart';
import 'theme/AppThemeLight.dart';

class App extends StatelessWidget {
  late final AppContainer _appContainer;
  late final AppAuth _appAuth;
  late final AppRouter _appRouter;

  App(AppContainer appContainer, {super.key}) {
    _appContainer = appContainer;
    _appAuth = AppAuth(_appContainer.authRepository);
    _appRouter = AppRouter(appAuth: _appAuth);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppAuth>.value(value: _appAuth),
        Provider<AppRouter>.value(value: _appRouter),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final router = context.watch<AppRouter>().router;

          return MaterialApp.router(
            routerConfig: router,
            title: 'Moto events',
            theme: AppThemeLight().toThemeData(),
            darkTheme: AppThemeDark().toThemeData(),
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
