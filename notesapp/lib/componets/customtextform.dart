import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final String? Function(String?) valid;
  final Widget? suffIcon, preIcon;
  final int? minLine;
  final int? maxline;

  const CustTextFormSign({
    Key? key,
    required this.hint,
    required this.mycontroller,
    required this.valid,
    this.suffIcon,
    this.preIcon,
    this.minLine,
    this.maxline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        minLines: minLine,
        maxLines: maxline,
        validator: valid,
        controller: mycontroller,
        cursorColor: const Color(0xFFFFCE00),
        decoration: InputDecoration(
          suffixIcon: suffIcon,
          prefixIcon: preIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xff8889B9),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE4E4F9),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
