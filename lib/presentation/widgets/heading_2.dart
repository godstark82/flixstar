import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  final String text;
  const Heading2({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.orange));
  }
}
