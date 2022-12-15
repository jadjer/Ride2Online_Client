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

class AppThemeLight {
  Color bg1 = const Color(0xffffffff);
  Color surface1 = const Color(0xFFFFFFFF);
  Color surface2 = const Color(0xffebf0f3);
  Color accent1 = const Color(0xffff392b);
  Color greyWeak = const Color(0xffcccccc);
  Color grey = const Color(0xff999999);
  Color greyMedium = const Color(0xff747474);
  Color greyStrong = const Color(0xff333333);
  Color focus = const Color(0xffd81e1e);
  Color mainTextColor = Colors.black;
  Color inverseTextColor = Colors.white;

  ThemeData toThemeData() {
    var theme = ThemeData.from(
      useMaterial3: true,
      textTheme: ThemeData.light().textTheme,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: accent1,
          primaryContainer: shift(accent1, .1),
          secondary: accent1,
          secondaryContainer: shift(accent1, .1),
          background: bg1,
          surface: surface1,
          onBackground: mainTextColor,
          onSurface: mainTextColor,
          onError: mainTextColor,
          onPrimary: inverseTextColor,
          onSecondary: inverseTextColor,
          error: focus),
    );

    theme.copyWith(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: surface1,
          selectionHandleColor: Colors.transparent,
          selectionColor: surface1,
        ),
        highlightColor: shift(accent1, .1));

    return theme;
  }

  Color shift(Color c, double amt) {
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness = (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }
}
