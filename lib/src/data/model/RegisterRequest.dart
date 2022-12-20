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

class RegisterRequest {
  final String phone;
  final String username;
  final String password;
  final int verifyCode;

  RegisterRequest({required this.phone, required this.username, required this.password, required this.verifyCode});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'username': username,
      'password': password,
      'verifyCode': verifyCode,
    };
  }
}
