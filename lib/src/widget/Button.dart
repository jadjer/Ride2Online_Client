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

class Button extends StatelessWidget {
  final VoidCallback? onClick;
  final Color? color;
  final String text;
  final double? fontSize;
  final double? width;
  final double? height;

  const Button({
    super.key,
    this.onClick,
    this.color,
    this.text = 'click',
    this.fontSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: color,
      textStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
    );
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width, height: height),
      child: ElevatedButton(
        style: style,
        onPressed: onClick,
        child: Text(text),
      ),
    );
  }
}

class MediumButton extends Button {
  @override
  final VoidCallback? onClick;
  @override
  final String text;

  const MediumButton({
    Key? key,
    this.text = 'click',
    this.onClick,
  }) : super(
          key: key,
          color: const Color(0xFF58C0EA),
          fontSize: 17,
          height: 50,
          width: 224,
          onClick: onClick,
          text: text,
        );
}

class LargeButton extends Button {
  @override
  final VoidCallback? onClick;
  @override
  final String text;

  const LargeButton({
    Key? key,
    this.text = 'click',
    this.onClick,
  }) : super(
          key: key,
          color: const Color(0xFF5956E9),
          fontSize: 20,
          height: 70,
          width: 314,
          onClick: onClick,
          text: text,
        );
}
