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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ride2online/src/data/repository/AuthRepository.dart';

class AuthService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();

  late bool _authenticated;
  late AuthRepository _repository;

  AuthService(AuthRepository repository) {
    _authenticated = false;
    _repository = repository;
  }

  bool get authenticated => _authenticated;

  Future<void> signIn(String username, String password) async {
    var result = await _repository.login(username, password);
    if (result.success) {
      await _storage.write(key: 'token_access', value: result.payload!.token.tokenAccess);
      await _storage.write(key: 'token_refresh', value: result.payload!.token.tokenRefresh);

      _authenticated = true;
    }

    notifyListeners();
  }

  Future<void> signUp(String username, String phone, String password, int code) async {
    var result = await _repository.register(username, phone, password, code);
    if (result.success) {
      await _storage.write(key: 'token_access', value: result.payload!.token.tokenAccess);
      await _storage.write(key: 'token_refresh', value: result.payload!.token.tokenRefresh);

      _authenticated = true;
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    await _storage.delete(key: 'token_access');
    await _storage.delete(key: 'token_refresh');

    _authenticated = false;
    notifyListeners();
  }
}


