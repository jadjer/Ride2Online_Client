// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ride2online/src/data/model/LoginRequest.dart';

class LoginScreen extends StatelessWidget {
  final _isShow = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key, required Null Function(LoginRequest request) onSignIn});

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset('assets/svg/logo_full.svg');

    final usernameField = TextField(
      autofocus: true,
      obscureText: false,
      controller: _passwordController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextField(
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo,
            Text('Sign in', style: Theme.of(context).textTheme.headlineMedium),
            usernameField,
            passwordField,
            TextButton(
              onPressed: () async {
                // await auth.signIn(_usernameController.value.text, _passwordController.value.text);
              },
              child: const Text('Sign in'),
            ),
            Text("or", style: Theme.of(context).textTheme.headlineSmall),
            TextButton(
              onPressed: () async {},
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
