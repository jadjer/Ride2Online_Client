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
import 'package:ride2online/src/data/model/EventResponse.dart';
import 'package:ride2online/src/data/model/EventsResponse.dart';
import 'package:ride2online/src/data/repository/EventsRepository.dart';

class EventsRepositoryImpl implements EventsRepository {
  final _baseUrl = 'ride2online.jadjer.by';

  late Client _client;

  EventsRepositoryImpl(Client client) {
    _client = client;
  }

  @override
  Future<EventResponse> createEvent(Event request) async {
    final url = Uri.https(_baseUrl, 'events');

    final response = await _client.post(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return EventResponse.fromJson(responseJson);
  }

  @override
  Future<EventResponse> getEvent(int eventId) async {
    final url = Uri.https(_baseUrl, 'events/$eventId');

    final response = await _client.get(url);
    final responseJson = jsonDecode(response.body);

    return EventResponse.fromJson(responseJson);
  }

  @override
  Future<EventsResponse> getEvents() async {
    throw EventsResponse(success: false, message: 'Unimplemented get events method');
  }

  @override
  Future<EventResponse> updateEvent(int eventId, Event request) async {
    final url = Uri.https(_baseUrl, 'events/$eventId');

    final response = await _client.patch(url, body: jsonEncode(request.toJson()));
    final responseJson = jsonDecode(response.body);

    return EventResponse.fromJson(responseJson);
  }

  @override
  Future<EventResponse> deleteEvent(int eventId) async {
    final url = Uri.https(_baseUrl, 'events/$eventId');

    final response = await _client.delete(url);
    final responseJson = jsonDecode(response.body);

    return EventResponse.fromJson(responseJson);
  }
}
