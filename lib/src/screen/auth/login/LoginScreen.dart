// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ride2online/src/AppRouteName.dart';
import 'package:ride2online/src/service/AuthService.dart';
import 'package:ride2online/src/widget/AuthScaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    if (auth.isAuthenticated) {
      Future.microtask(() {
        context.goNamed(AppRouteName.events);
      });
    }

    return AuthScaffold(
      title: 'Login',
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
                  decoration: InputDecoration(border: InputBorder.none, hintText: 'Username', hintStyle: TextStyle(color: Colors.grey[400])),
                  autofocus: true,
                  controller: _usernameTextController,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none, hintText: 'Password', hintStyle: TextStyle(color: Colors.grey[400])),
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTextController,
                ),
              )
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
              child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          onTap: () async {
            final username = _usernameTextController.text;
            final password = _passwordTextController.text;

            await auth.signIn(username, password);
          },
        ),
        const SizedBox(height: 70),
        InkWell(
          child: const Text('Change password', style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1))),
          onTap: () {
            context.goNamed(AppRouteName.changePasswordPhone);
          },
        ),
      ],
    );
  }
}
