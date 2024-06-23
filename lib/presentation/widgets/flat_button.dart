import 'package:flutter/material.dart';

class FlatBtn extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  const FlatBtn(
      {super.key, required this.iconData, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade900,
            radius: 23,
            child: Icon(iconData, color: Colors.white),
          ),
          SizedBox(height: 2),
          Text(text),
        ],
      ),
    );
  }
}
