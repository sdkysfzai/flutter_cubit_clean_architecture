import 'package:flutter/material.dart';
import 'package:flutter_miload/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key, required this.buttonText, required this.onPressed, required this.color});
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: const BorderSide(
            color: greyColor,
            width: 0.2,
          ),
          backgroundColor: widget.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(widget.buttonText,
            style: GoogleFonts.inter(
              color: secondaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600
            )),
      ),
    );
  }
}
