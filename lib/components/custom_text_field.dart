import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
      this.hint,
      this.obscure = false,
      this.validator,
      this.onChanged});
  final IconData? icon;
  final String? hint;
  final bool obscure;
  final FormFieldValidator<String>? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 15.0,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        validator: validator,
        autofocus: true,
        obscureText: obscure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: Icon(icon),
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          ),
        ),
      ),
    );
  }
}
