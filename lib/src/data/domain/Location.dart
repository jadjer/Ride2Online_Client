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

import 'dart:ffi';

class Location {
  final int id;
  final String name;
  final String description;
  final Float longitude;
  final Float latitude;

  Location({
    required this.id,
    required this.name,
    required this.description,
    required this.longitude,
    required this.latitude,
  });

  Location fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      longitude: json['longitude'] as Float,
      latitude: json['latitude'] as Float,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
