import 'package:flutter/material.dart';

class OtherOptions extends StatelessWidget {
  final Icon iconData;
  final String text;
  final VoidCallback? onPressed;
  const OtherOptions(
      {super.key, required this.iconData, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                iconData,
                SizedBox(height: 5),
                Text(
                  text,
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
        ),
      ),
    );
  }
}
