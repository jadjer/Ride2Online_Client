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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride2online/src/_data.dart';
import 'package:ride2online/src/service/EventsService.dart';
import 'package:ride2online/src/widget/EventDetails.dart';

class EventDetailsScreen extends StatelessWidget {
  final int eventId;

  const EventDetailsScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    final events = context.read<EventsService>();
    final futureEvent = events.getEventById(eventId);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<Event?>(
          future: futureEvent,
          builder: (BuildContext context, AsyncSnapshot<Event?> snapshot) {
            if (snapshot.hasData) {
              return EventDetails(event: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
