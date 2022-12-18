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

import 'package:http/http.dart' as http;
import 'package:ride2online/src/data/repository/EventRepository.dart';

class EventRepositoryImpl implements EventRepository {
  final String basePath = 'https://auth.ride2online.jadjer.by';

  late final http.Client _client;

  EventRepositoryImpl(http.Client client) {
    _client = client;
  }
}
