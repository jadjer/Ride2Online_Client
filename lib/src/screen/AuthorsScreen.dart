// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data/model/Library.dart';
import '../routing/RouteStateScope.dart';
import '../widget/AuthorList.dart';

class AuthorsScreen extends StatelessWidget {
  final String title = 'Authors';

  const AuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: AuthorList(
          authors: libraryInstance.allAuthors,
          onTap: (author) {
            RouteStateScope.of(context).go('/author/${author.id}');
          },
        ),
      );
}
