// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:ride2online/src/widget/FadeTransitionPage.dart';

import 'RideEventScaffold.dart';
import 'events/EventsScreen.dart';
import 'setting/SettingsScreen.dart';

class RideEventScaffoldBody extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const RideEventScaffoldBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // A nested Router isn't necessary because the back button behavior doesn't
    // need to be customized.
    return Navigator(
      key: navigatorKey,
      onPopPage: (route, dynamic result) => route.didPop(result),
      pages: [
        // if (currentRoute.pathTemplate.startsWith('/authors'))
        //   const FadeTransitionPage<void>(
        //     key: ValueKey('authors'),
        //     child: AuthorsScreen(),
        //   )
        // else if (currentRoute.pathTemplate.startsWith('/settings'))
        //   const FadeTransitionPage<void>(
        //     key: ValueKey('settings'),
        //     child: SettingsScreen(),
        //   )
        // else if (currentRoute.pathTemplate.startsWith('/events') || currentRoute.pathTemplate == '/')
        //   const FadeTransitionPage<void>(
        //     key: ValueKey('events'),
        //     child: EventsScreen(),
        //   )

        // Avoid building a Navigator with an empty `pages` list when the
        // RouteState is set to an unexpected path, such as /signin.
        //
        // Since RouteStateScope is an InheritedNotifier, any change to the
        // route will result in a call to this build method, even though this
        // widget isn't built when those routes are active.
        // else
          FadeTransitionPage<void>(
            key: const ValueKey('empty'),
            child: Container(),
          ),
      ],
    );
  }
}
