import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final _isObscure = true.obs;

  PasswordInputWidget({Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        margin: const EdgeInsets.all(10),
        child: Obx(
              () =>
              TextField(
                controller: controller,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
                maxLines: 1,
                obscureText: _isObscure.value,
                decoration: InputDecoration(
                    labelText: title,
                    labelStyle: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                    filled: true,
                    fillColor: Theme
                        .of(context)
                        .colorScheme
                        .primaryContainer,
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure.value
                          ? Icons.visibility
                          : Icons.visibility_off
                      ),
                      onPressed: () => _isObscure.value = !_isObscure.value,
                    )),
              ),
        )
    );
  }
}
