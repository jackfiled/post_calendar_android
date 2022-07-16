import 'package:flutter/material.dart';

/// 开屏加载界面
class OpenLoadingPage extends StatelessWidget {
  const OpenLoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(top: 500),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "邮历",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "传邮万里",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
          )
      )
    );
  }
}
