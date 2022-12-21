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
import 'package:ride2online/src/data/model/LoginRequest.dart';
import 'package:ride2online/src/data/model/RegisterRequest.dart';
import 'package:ride2online/src/data/repository/AuthRepository.dart';

class AuthService extends ChangeNotifier {
  late bool _authenticated;
  late AuthRepository _repository;
  late FlutterSecureStorage _storage;

  AuthService(AuthRepository repository) {
    _authenticated = false;
    _repository = repository;
    _storage = const FlutterSecureStorage();
  }

  bool get authenticated => _authenticated;

  Future<void> signIn(String username, String password) async {
    final loginRequest = LoginRequest(username: username, password: password);
    final result = await _repository.login(loginRequest);
    if (result.success) {
      await _storage.write(key: 'token_access', value: result.auth!.token.tokenAccess);
      await _storage.write(key: 'token_refresh', value: result.auth!.token.tokenRefresh);

      _authenticated = true;
    }

    notifyListeners();
  }

  Future<void> signUp(String phone, String username, String password, int verifyCode) async {
    final registerRequest = RegisterRequest(phone: phone, username: username, password: password, verifyCode: verifyCode);
    final result = await _repository.register(registerRequest);
    if (result.success) {
      await _storage.write(key: 'token_access', value: result.auth!.token.tokenAccess);
      await _storage.write(key: 'token_refresh', value: result.auth!.token.tokenRefresh);

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
