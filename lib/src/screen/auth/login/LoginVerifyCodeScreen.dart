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

class LoginVerifyCodeScreen extends StatelessWidget {
  const LoginVerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/background.png'), fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/image/clock.png'))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text('Phone verification', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(143, 148, 251, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Color.fromRGBO(255, 255, 255, .2), blurRadius: 20.0, offset: Offset(0, 10)),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLength: 6,
                          decoration: InputDecoration(border: InputBorder.none, hintText: 'Verify code', hintStyle: TextStyle(color: Colors.grey[400])),
                          autofocus: true,
                          keyboardType: TextInputType.number,
                        ),
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
                          child: Text("Reset", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      onTap: () {
                        context.goNamed(AppRouteName.changePassword);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
