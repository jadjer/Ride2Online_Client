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

import 'package:http/http.dart' as http;
import 'package:ride2online/src/data/model/TokenResponse.dart';
import 'package:ride2online/src/data/repository/TokenRepository.dart';

class TokenRepositoryImpl implements TokenRepository {
  late final http.Client _client;

  TokenRepositoryImpl(http.Client client) {
    _client = client;
  }

  @override
  Future<TokenResponse> getToken(String username, String password) async {
    final url = Uri.https('auth.ride2online.jadjer.by', 'token/get');

    final headers = {
      'content-type': 'application/json',
      'x-api-key': 'qwe',
    };
    final body = {
      'username': username,
      'password': password,
    };

    final response = await _client.post(url, headers: headers, body: jsonEncode(body));
    final responseJson = jsonDecode(response.body);

    return TokenResponse.fromJson(responseJson);
  }

  @override
  Future<TokenResponse> refreshToken(String tokenAccess, String tokenRefresh) async {
    final url = Uri.https('auth.ride2online.jadjer.by', 'token/refresh');

    final headers = {
      'content-type': 'application/json',
      'x-api-key': 'qwe'
    };
    final body = {
      'token_access': tokenAccess,
      'token_refresh': tokenRefresh
    };

    final response = await _client.post(url, headers: headers, body: jsonEncode(body));
    final responseJson = jsonDecode(response.body);

    return TokenResponse.fromJson(responseJson);
  }
}
