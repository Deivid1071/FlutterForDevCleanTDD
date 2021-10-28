import 'package:flutter/material.dart';

class TextHead1 extends StatelessWidget {
  final title;
  const TextHead1({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
