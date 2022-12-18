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

import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/widget/EventList.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(user.username),
        ),
        body: Center(
          // child: Column(
          //   children: [
          //     Expanded(
          //       child: EventList(
          //         events: user.books,
          //         onTap: (book) {
          //           RouteStateScope.of(context).go('/book/${book.id}');
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ),
      );
}
