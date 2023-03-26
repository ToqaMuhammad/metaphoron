import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final Function(String textInput) setValue;
  final Function(String value) validation;
  final Function(String value)? onChange;
  final bool obscureText;
  final TextInputType textInputType;
  final String? initialValue;

  const CustomTextField({Key? key, required this.text, this.obscureText = false, this.textInputType = TextInputType.text, required this.setValue, required this.validation, this.initialValue, this.onChange}) : super(key: key);

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(obscureText: obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visibility = false;
  bool obscureText;

  _CustomTextFieldState({required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey.shade600,
      keyboardType: widget.textInputType,
      initialValue: widget.initialValue,
      style: TextStyle(
        color: Colors.grey.shade600,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(!_visibility ? Icons.visibility_off : Icons.visibility),
          color: Colors.grey.shade500,
          onPressed: () {
            setState(() {
              _visibility = !_visibility;
              obscureText = !obscureText;
            });
          },
        ) : null,
        labelText: widget.text,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade500,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        focusColor: Colors.white,
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.brown.shade300,
            //width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.brown.shade300,
            //width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            //width: 2.0,
          ),
        ),
      ),
      onSaved: (value){
        widget.setValue(value!);
      },
      validator: (value){
        return widget.validation(value!);
      },
      onChanged: widget.onChange != null ? (value){
        widget.onChange!(value);
      } : null,
    );
  }
}
