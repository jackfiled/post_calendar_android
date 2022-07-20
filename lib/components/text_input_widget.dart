import 'package:flutter/material.dart';

/// 文字输入框组件
class TextInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const TextInputWidget({
    Key? key,
    required this.controller,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        style: Theme
            .of(context)
            .textTheme
            .bodyText2,
        maxLines: 2,
        decoration: InputDecoration(
            labelText: title,
            labelStyle: Theme
                .of(context)
                .textTheme
                .bodyText1,
            border: const OutlineInputBorder()
        ),
      ),
    );
  }
}
