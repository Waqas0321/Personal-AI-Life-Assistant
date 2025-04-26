import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Const/app_colors.dart';

class CustomInputTextField extends StatefulWidget {
  const CustomInputTextField({
    super.key,
    required this.hintText,
    this.hasSuffixIcon = false,
    this.numberKeyboard = false,
    this.isFilled = false,
    this.prefixIcon = false,
    this.filledColor = AppColors.white,
    required this.textEditingController,
    this.emptyValueErrorText = "Please fill this field",
    this.isValidator = true,
    this.isObsecure = false,
    this.validator,
    this.width,
    this.maxLines = 1,
    this.borderRadius = 13,
    this.borderRestriction = true,
    this.borderColor = AppColors.blackish,
    required this.labelText,
    this.onChange,
  });

  final String hintText;
  final String labelText;
  final bool hasSuffixIcon;
  final bool numberKeyboard;
  final bool prefixIcon;
  final bool isFilled;
  final Color borderColor;
  final Color filledColor;
  final TextEditingController textEditingController;
  final String emptyValueErrorText;
  final bool isValidator;
  final bool isObsecure;
  final Function(String)? onChange;
  final double borderRadius;
  final String? Function(String?)? validator;
  final double? width;
  final int maxLines;
  final bool borderRestriction;

  @override
  CustomInputTextFieldState createState() => CustomInputTextFieldState();
}

class CustomInputTextFieldState extends State<CustomInputTextField> {
  bool isObscured = true;

  @override
  void initState() {
    isObscured = widget.isObsecure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      onChanged: widget.onChange,
      keyboardType:
          widget.numberKeyboard ? TextInputType.number : TextInputType.text,
      obscureText: isObscured,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColors.black,
      ),
      cursorColor: AppColors.primary,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: widget.isFilled,
        fillColor: widget.filledColor,
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.maxLines >= 2 ? 6 : 2,
          horizontal: 18,
        ),
        prefixIcon:
            widget.prefixIcon
                ? const Icon(Icons.search, color: AppColors.whitish)
                : null,
        suffixIcon:
            widget.hasSuffixIcon
                ? IconButton(
                  icon: Icon(
                    isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    color: AppColors.blackish,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                )
                : null,
        hintText: widget.hintText,
        labelText: widget.maxLines >= 2 ? null : widget.labelText,
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.blackish,
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.blackish,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              widget.isFilled && widget.borderRestriction
                  ? BorderSide.none
                  : BorderSide(color: widget.borderColor, width: 0.6),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              widget.isFilled && widget.borderRestriction
                  ? BorderSide.none
                  : BorderSide(color: widget.borderColor, width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              widget.isFilled && widget.borderRestriction
                  ? BorderSide.none
                  : BorderSide(color: widget.borderColor, width: 0.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              widget.isFilled && widget.borderRestriction
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.red, width: 0.6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide:
              widget.isFilled && widget.borderRestriction
                  ? BorderSide.none
                  : const BorderSide(color: AppColors.red, width: 0.6),
        ),
      ),
      validator:
          widget.isValidator
              ? widget.validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return widget.emptyValueErrorText;
                    }
                    return null;
                  }
              : null,
    );
  }
}
