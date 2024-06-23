import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayButton extends StatelessWidget {
  final Icon icon;
  final Widget label;
  final Color? bgColor;
  final Color? fgColor;
  final VoidCallback onPressed;
  const PlayButton({
    super.key,
    required this.icon,
    this.bgColor = Colors.white,
    this.fgColor = Colors.black,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(bgColor),
          foregroundColor: WidgetStatePropertyAll(fgColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          )),
        ),
        onPressed: onPressed, icon: icon, label: label),
    );
  }
}
