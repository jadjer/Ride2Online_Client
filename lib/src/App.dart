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
import 'package:provider/provider.dart';
import 'package:ride2online/src/data/AppContainer.dart';

import 'AppRouter.dart';
import 'service/AuthService.dart';
import 'service/EventsService.dart';
import 'theme/AppThemeDark.dart';
import 'theme/AppThemeLight.dart';

class App extends StatelessWidget {
  late final AppRouter _appRouter;
  late final AuthService _authService;
  late final AppContainer _appContainer;
  late final EventsService _eventsService;

  App(AppContainer appContainer, {super.key}) {
    _appContainer = appContainer;
    _authService = AuthService(_appContainer.authRepository);
    _appRouter = AppRouter(auth: _authService);
    _eventsService = EventsService(_appContainer.eventsRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>.value(value: _authService),
        Provider<AppRouter>.value(value: _appRouter),
        Provider<EventsService>.value(value: _eventsService),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final appRoute = context.watch<AppRouter>();

          return MaterialApp.router(
            routerConfig: appRoute.router,
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
