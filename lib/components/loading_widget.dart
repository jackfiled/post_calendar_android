import 'package:flutter/material.dart';

/// 加载中界面
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  final loadingTextStyle = const TextStyle(
    fontSize: 26,
    color: Color.fromARGB(132, 124, 124, 124),
    fontStyle: FontStyle.italic
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "加载中...",
        style: loadingTextStyle
      ),
    );
  }
}