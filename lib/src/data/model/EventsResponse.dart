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

import 'package:ride2online/src/_data.dart';

class EventsResponse {
  final bool success;
  final String message;
  final List<Event> events;

  EventsResponse({
    required this.success,
    required this.message,
    required this.events,
  });

  factory EventsResponse.fromJson(Map<String, dynamic> json) {
    final success = json['success'] as bool;
    final message = json['message'] as String;

    if (!success) return EventsResponse(success: success, message: message, events: []);

    final payload = json['payload'];
    if (payload == null) return EventsResponse(success: success, message: message, events: []);

    final eventsData = payload['events'] as List<dynamic>;
    final events = eventsData.map((event) => Event.fromJson(event)).toList();

    return EventsResponse(
      success: success,
      message: message,
      events: events,
    );
  }
}
