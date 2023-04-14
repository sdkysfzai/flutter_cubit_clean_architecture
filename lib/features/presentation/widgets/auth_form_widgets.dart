import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts.dart';

class AuthenticationFormField extends StatefulWidget {
  const AuthenticationFormField({
    this.validator,
    Key? key,
    required this.prefix,
    TextEditingController? controller,
    required this.isPasswordField,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String prefix;
  final FormFieldValidator<String>? validator;
  final bool isPasswordField;

  @override
  State<AuthenticationFormField> createState() => _AuthenticationFormFieldState();
}

class _AuthenticationFormFieldState extends State<AuthenticationFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 65,
        padding: const EdgeInsets.symmetric(vertical: defaultPaddingMin, horizontal: 0),
        child: TextFormField(
          cursorColor: Colors.black,
          style: GoogleFonts.inter(color: Colors.black),
          validator: widget.validator,
          obscureText: widget.isPasswordField ? _obscureText : false,
          controller: widget._controller,
          onChanged: (val) {
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding),
            filled: true,
            fillColor: greyColor.shade100,
            hintText: 'Enter your ${widget.prefix}',
            hintStyle: GoogleFonts.inter(color: greyColor),
            suffixIcon: GestureDetector(
              onTap: (){
                setState(() {
                  _obscureText = !_obscureText;
                });
                
              },
              child: widget.isPasswordField == true ? Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: 
              _obscureText ? greyColor : blueColor, ) : const Text('')
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(defaultCircularRadius),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ));
  }
}