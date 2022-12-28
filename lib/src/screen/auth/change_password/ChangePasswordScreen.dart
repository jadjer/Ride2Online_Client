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
import 'package:provider/provider.dart';
import 'package:ride2online/src/AppRouteName.dart';
import 'package:ride2online/src/service/ChangePasswordService.dart';
import 'package:ride2online/src/widget/AuthScaffold.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _passwordTextController = TextEditingController();
  final _verificationCodeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final changePassword = context.watch<ChangePasswordService>();

    if (changePassword.isChanged) {
      Future.microtask(() {
        context.goNamed(AppRouteName.login);
      });
    }

    return AuthScaffold(
      title: 'Change password',
      widgets: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(143, 148, 251, 1),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(255, 255, 255, .2), blurRadius: 20.0, offset: Offset(0, 10)),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none, hintText: 'Password', hintStyle: TextStyle(color: Colors.grey[400])),
                  autofocus: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTextController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLength: 6,
                  decoration: InputDecoration(border: InputBorder.none, hintText: 'Verify code', hintStyle: TextStyle(color: Colors.grey[400])),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  controller: _verificationCodeTextController,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
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
              child: Text("Change", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          onTap: () async {
            final password = _passwordTextController.text;
            final verificationCode = int.parse(_verificationCodeTextController.text);

            await changePassword.changePassword(password, verificationCode);
          },
        ),
      ],
    );
  }
}
