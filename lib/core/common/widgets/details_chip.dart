import 'package:flutter/material.dart';

class DetailsChip extends StatelessWidget {
  final String text;
  const DetailsChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 5,
          width: 5,
          decoration: BoxDecoration(
              color: Colors.amber.shade600,
              borderRadius: BorderRadius.circular(50)),
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
