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

import 'dart:async';

import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/data/model/AuthResponse.dart';
import 'package:ride2online/src/data/model/ChangePasswordRequest.dart';
import 'package:ride2online/src/data/model/ChangePasswordResponse.dart';
import 'package:ride2online/src/data/model/ExistResponse.dart';
import 'package:ride2online/src/data/model/LoginRequest.dart';
import 'package:ride2online/src/data/model/PhoneTokenResponse.dart';
import 'package:ride2online/src/data/model/RegisterRequest.dart';
import 'package:ride2online/src/data/model/TokenResponse.dart';

abstract class AuthRepository {
  Future<PhoneTokenResponse> getVerificationCode(Phone request);

  Future<AuthResponse> login(LoginRequest request);

  Future<AuthResponse> register(RegisterRequest request);

  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);

  Future<TokenResponse> getToken(LoginRequest request);

  Future<TokenResponse> refreshToken(Token request);

  Future<ExistResponse> existPhone(Phone phone);

  Future<ExistResponse> existUsername(Username username);
}
