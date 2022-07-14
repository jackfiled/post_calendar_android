import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    // 重写主题中的部分参数
    textTheme: const TextTheme().copyWith(
        headline4: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        headline5: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          color: Colors.black
        ),
        subtitle1: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        // 用于详情的预览
        bodyText1: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.grey
        ),
        // 用于详情的具体显示
        bodyText2: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black
        )
      )
  );
}
