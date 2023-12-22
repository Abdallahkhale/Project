import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color fdefaultColor = Color(0xFF30F020);
const Color sdefaultcolor = Color(0xFF959E95);
const Color tdefaultcolor = Color(0xFFD9D9D9);

final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController ageController = TextEditingController();

Widget DefaultButton({
  double width = 336,
  Color background = fdefaultColor,
  double height = 56,
  double radius = 5,
  required VoidCallback function,
  required String text,
  bool isUpper = true, required Future<void> Function() onPressed,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: GoogleFonts.outfit(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      ),
    ),
  );
}

Widget fButton({
  double width = 170,
  double height = 50,
  required VoidCallback function,
  required String text,
  bool isUpper = true,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: fdefaultColor, width: 1),
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: GoogleFonts.outfit(
            fontSize: 16, fontWeight: FontWeight.w600, color: sdefaultcolor),
      ),
    ),
  );
}

Widget DefaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String? label,
  required IconData prefix,
  VoidCallback? suffixPressed,
  IconData? suffix,
  required String? Function(String? value) validate,
  double textFieldHeight = 25.0,
  double leftPadding = 16.0,
  double width = 336.0,
}) {
  Color activeColor = fdefaultColor;
  Color inactiveColor = sdefaultcolor;

  return Container(
    width: width,
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
      validator: validate,
      cursorColor: activeColor,
      style: GoogleFonts.outfit(
          color: inactiveColor, fontWeight: FontWeight.w600, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: inactiveColor),
        prefixIcon: Icon(prefix, color: inactiveColor),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(suffix, color: inactiveColor),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: activeColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: inactiveColor),
        ),
        contentPadding: EdgeInsets.fromLTRB(
          leftPadding,
          (60.0 - textFieldHeight) / 2,
          0,
          (60.0 - textFieldHeight) / 2,
        ),
      ),
    ),
  );
}

class OTPTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  OTPTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: fdefaultColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: fdefaultColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: fdefaultColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        style: GoogleFonts.outfit(
            fontSize: 24, fontWeight: FontWeight.normal, color: sdefaultcolor),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
