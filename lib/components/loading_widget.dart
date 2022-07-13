import 'package:flutter/material.dart';

/// 加载中界面
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "加载中...",
        style: Theme.of(context).textTheme.headline3
      ),
    );
  }
}