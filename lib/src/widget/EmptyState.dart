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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride2online/src/widget/Button.dart';

class EmptyState extends StatelessWidget {
  final String path;
  final String title;
  final String description;
  final String textButton;
  final VoidCallback? onClick;

  const EmptyState({Key? key, this.path = '', this.title = 'Upss', this.description = 'Something went wrong', this.onClick, this.textButton = 'Click'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage(path)),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
            ),
          ),
          const SizedBox(height: 20),
          Center(
              child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
          )),
          const SizedBox(height: 24),
          MediumButton(
            onClick: onClick,
            text: textButton,
          ),
        ],
      ),
    );
  }
}
