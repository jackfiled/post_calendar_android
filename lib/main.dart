import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:post_calendar_android/routes/route_config.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.main,
      getPages: RouteConfig.getPages,
    );
  }
}
