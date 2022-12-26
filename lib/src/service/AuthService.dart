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

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/data/model/LoginRequest.dart';
import 'package:ride2online/src/data/repository/AuthRepository.dart';

class AuthService extends ChangeNotifier {
  late AuthRepository _repository;
  late FlutterSecureStorage _storage;
  late String? _errorMessage;
  late bool _isAuthenticated;

  AuthService(AuthRepository repository) {
    _storage = const FlutterSecureStorage(
      iOptions: IOSOptions(accountName: 'by.jadjer.ride2online'),
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
    _repository = repository;
    _errorMessage = null;
    _isAuthenticated = false;

    init();
  }

  Future<void> init() async {
    String? tokenAccess = await _storage.read(key: 'token_access');
    if (tokenAccess != null) {
      _isAuthenticated = true;
    }
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<bool> existUsername(String username) async {
    log('Check if username $username is exists');

    final usernameRequest = Username(username: username);
    final result = await _repository.existUsername(usernameRequest);
    if (result.success) {
      return true;
    }

    return false;
  }

  Future<void> signIn(String username, String password) async {
    log('Try login');

    final loginRequest = LoginRequest(username: username, password: password);
    final result = await _repository.login(loginRequest);
    if (result.success) {
      log('Login success');

      await _storage.write(key: 'token_access', value: result.auth!.token.tokenAccess);
      await _storage.write(key: 'token_refresh', value: result.auth!.token.tokenRefresh);
    } else {
      log('Login failed');

      _errorMessage = result.message;
      log(_errorMessage!);
    }

    notifyListeners();
  }

  Future<void> signOut() async {
    log('Try logout');

    await _storage.delete(key: 'token_access');
    await _storage.delete(key: 'token_refresh');

    notifyListeners();
  }
}
