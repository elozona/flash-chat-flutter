import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({this.color, required this.onPressed, this.text = ''});

  final Color? color;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
