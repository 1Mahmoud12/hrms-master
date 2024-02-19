import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? labelText;
  final bool? password;
  final int? maxLines;
  final TextInputType? textInputType;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final double? fontSizeHintText;
  final bool? validationOnNumber;
  final void Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.password = false,
    this.maxLines,
    this.textInputType,
    this.fillColor,
    this.fontSizeHintText,
    this.focusedBorderColor,
    this.validationOnNumber,
    this.labelText,
    this.enabled,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = false;

  @override
  void initState() {
    // TODO: implement initState
    _obscureText = widget.password!;

    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool validateField(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ///You must add [[width]] in SizeBox before use it
    return TextFormField(
      obscureText: _obscureText,
      controller: widget.controller,
      keyboardType: widget.textInputType ?? TextInputType.visiblePassword,
      style: const TextStyle(color: AppColors.textColor),
      validator: (value) {
        if (!validateField(value!)) {
          return 'Empty Field';
        }
        return null;
      },
      inputFormatters: [
        if (widget.validationOnNumber != null && widget.validationOnNumber!) FilteringTextInputFormatter.allow(RegExp(r'^\d{0,2}$')),
      ],
      maxLines: widget.maxLines ?? 1,
      cursorColor: AppColors.textColorTextFormField,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        hintText: widget.hintText.tr,
        hintStyle: TextStyle(color: AppColors.textColorTextFormField, fontSize: (widget.fontSizeHintText ?? 14).sp, fontWeight: FontWeight.bold),
        prefixIcon: widget.prefixIcon,
        label: widget.labelText,
        labelStyle: const TextStyle(color: Colors.black),
        enabled: widget.enabled ?? true,
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: widget.focusedBorderColor ?? Colors.black),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffixIcon: widget.password != null && widget.password!
            ? Padding(
                padding: const EdgeInsets.all(10.0).w,
                child: InkWell(
                  onTap: _toggle,
                  child: _obscureText
                      ? SvgPicture.asset(
                          Assets.eyePasswordShow,
                          fit: BoxFit.cover,
                        )
                      : SvgPicture.asset(
                          Assets.showPassword,
                          fit: BoxFit.cover,
                        ),
                ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}
