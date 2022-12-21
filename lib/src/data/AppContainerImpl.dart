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

import 'package:http_interceptor/http_interceptor.dart';
import 'package:ride2online/src/data/AppContainer.dart';
import 'package:ride2online/src/data/repository/AuthRepository.dart';
import 'package:ride2online/src/data/repository/EventsRepository.dart';
import 'package:ride2online/src/data/repository/impl/AuthRepositoryImpl.dart';
import 'package:ride2online/src/data/repository/impl/EventsRepositoryImpl.dart';
import 'package:ride2online/src/util/ExpiredTokenRetryPolicy.dart';
import 'package:ride2online/src/util/interceptor/AcceptInterceptor.dart';
import 'package:ride2online/src/util/interceptor/ApiKeyInterceptor.dart';
import 'package:ride2online/src/util/interceptor/AuthTokenInterceptor.dart';
import 'package:ride2online/src/util/interceptor/ContentTypeInterceptor.dart';

class AppContainerImpl implements AppContainer {
  late Client _client;

  AppContainerImpl() {
    _client = InterceptedClient.build(
      interceptors: [
        AcceptInterceptor(),
        ContentTypeInterceptor(),
        ApiKeyInterceptor(),
        AuthTokenInterceptor(),
      ],
      retryPolicy: ExpiredTokenRetryPolicy(),
    );
  }

  @override
  AuthRepository get authRepository => AuthRepositoryImpl(_client);

  @override
  EventsRepository get eventsRepository => EventsRepositoryImpl(_client);
}
