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
import 'package:go_router/go_router.dart';
import 'package:ride2online/src/AppRouteName.dart';
import 'package:ride2online/src/widget/AuthScaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome',
      widgets: [
        InkWell(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ])),
            child: const Center(
              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          onTap: () {
            context.goNamed(AppRouteName.login);
          },
        ),
        const SizedBox(height: 30),
        // const Spacer(),
        InkWell(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(143, 148, 251, .6),
                ])),
            child: const Center(
              child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          onTap: () {
            context.goNamed(AppRouteName.registerPhone);
          },
        ),
      ],
    );
  }
}
