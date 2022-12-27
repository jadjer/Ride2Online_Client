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
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/data/repository/EventsRepository.dart';

class EventsService extends ChangeNotifier {
  late List<Event> _events;
  late EventsRepository _repository;

  EventsService(EventsRepository repository) {
    _events = [];
    _repository = repository;
  }

  Future<List<Event>> getEvents() async {
    try {
      log('Try get events');

      final result = await _repository.getEvents();
      if (!result.success) {
        return _events;
      }

      final events = result.events;

      _events = events;

      log('Get data success');
    } catch (e) {
      log(e.toString());
    }
    return _events;
  }

  Future<Event?> getEventById(int eventId) async {
    Event? event;

    try {
      log('Try get event with $eventId from local');

      event = _events.firstWhere((event) => (event.id == eventId));
    } catch (e) {
      log(e.toString());

      log('Try get event with $eventId from remove');

      final result = await _repository.getEvent(eventId);
      if (!result.success) {
        return null;
      }

      event = result.event;

      log('Get data success');
    }

    return event;
  }
}
