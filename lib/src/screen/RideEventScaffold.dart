// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class RideEventScaffold extends StatelessWidget {
  const RideEventScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final routeState = RouteStateScope.of(context);
    // final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
        // body: AdaptiveNavigationScaffold(
        //   // selectedIndex: selectedIndex,
        //   body: const RideEventScaffoldBody(),
        //   onDestinationSelected: (idx) {
        //     // if (idx == 0) routeState.go('/events/new');
        //     // if (idx == 1) routeState.go('/authors');
        //     // if (idx == 2) routeState.go('/settings');
        //   },
        //   destinations: const [
        //     AdaptiveScaffoldDestination(
        //       title: 'Events',
        //       icon: Icons.event,
        //     ),
        //     AdaptiveScaffoldDestination(
        //       title: 'Authors',
        //       icon: Icons.person,
        //     ),
        //     AdaptiveScaffoldDestination(
        //       title: 'Settings',
        //       icon: Icons.settings,
        //     ),
        //   ],
        // ),
        );
  }

  int _getSelectedIndex(String pathTemplate) {
    if (pathTemplate.startsWith('/events')) return 0;
    if (pathTemplate == '/authors') return 1;
    if (pathTemplate == '/settings') return 2;
    return 0;
  }
}
