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

import 'dart:convert';

import 'package:http/http.dart';
import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/data/model/AuthResponse.dart';
import 'package:ride2online/src/data/model/LoginRequest.dart';
import 'package:ride2online/src/data/model/RegisterRequest.dart';
import 'package:ride2online/src/data/model/TokenResponse.dart';
import 'package:ride2online/src/data/repository/AuthRepository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _baseUrl = 'auth.ride2online.jadjer.by';

  late Client _client;

  AuthRepositoryImpl(Client client) {
    _client = client;
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    final url = Uri.https(_baseUrl, 'login');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    final url = Uri.https(_baseUrl, 'register');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return AuthResponse.fromJson(responseJson);
  }

  @override
  Future<TokenResponse> getToken(LoginRequest request) async {
    final url = Uri.https(_baseUrl, 'token/get');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return TokenResponse.fromJson(responseJson);
  }

  @override
  Future<TokenResponse> refreshToken(Token request) async {
    final url = Uri.https(_baseUrl, 'token/refresh');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return TokenResponse.fromJson(responseJson);
  }
}
