import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final bool isLoading;
  final bool? iconExist;

  const CustomButton({Key? key, required this.text, required this.onClick, this.isLoading = false, this.iconExist,}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.brown[900],
            borderRadius: BorderRadius.circular(15)
        ),
        duration: const Duration(milliseconds: 400),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: !widget.isLoading ? Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white
              ),
            ) : Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.brown.shade900),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
