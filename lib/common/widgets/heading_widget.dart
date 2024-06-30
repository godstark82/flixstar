import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String text;
  const HeadingWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(children: [
          Container(
            height: 25,
            width: 5,
            decoration: BoxDecoration(
                color: Colors.amber.shade600,
                borderRadius: BorderRadius.circular(15)),
          ),
          SizedBox(width: 5),
          Text(text, style: Theme.of(context).textTheme.titleLarge)
        ]));
  }
}
