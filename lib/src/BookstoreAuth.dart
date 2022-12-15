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

import 'package:flutter/widgets.dart';

/// A mock authentication service
class BookstoreAuth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    // Sign in. Allow any password.
    _signedIn = true;
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is BookstoreAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class BookstoreAuthScope extends InheritedNotifier<BookstoreAuth> {
  const BookstoreAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static BookstoreAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BookstoreAuthScope>()!
      .notifier!;
}
