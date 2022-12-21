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
import 'package:ride2online/src/data/repository/EventsRepository.dart';

class EventsService {
  late EventsRepository _repository;

  EventsService(EventsRepository repository) {
    _repository = repository;
  }

  Future<List<Event>> getEvents() async {
    return [];
  }

  FutureOr<Event?> getEventById(int eventId) async {
    final result = await _repository.getEvent(eventId);
    if (result.success) {
      return result.event;
    }

    return null;
  }
}
