import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Const/app_colors.dart';


class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14,
    this.textColor = AppColors.black,
    required this.text,
    this.textAlign = TextAlign.center,
    this.underlined = false,
    this.limitedCharacters = false,
    this.noOfCharacter = 20,
    this.textOverflow = TextOverflow.ellipsis
  });

  final FontWeight fontWeight;
  final double fontSize;
  final Color textColor;
  final String text;
  final TextAlign textAlign;
  final bool underlined;
  final bool limitedCharacters;
  final int noOfCharacter;
  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
        overflow: textOverflow,
        textAlign: textAlign,
        limitedCharacters?  text.length > noOfCharacter ? "${text.substring(0, noOfCharacter)}..." : text: text,
        style: GoogleFonts.poppins(
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight,
            decoration:underlined? TextDecoration.underline:null,
            decorationColor: textColor
        ));
  }
}
