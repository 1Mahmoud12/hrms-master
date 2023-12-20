import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Function onPress;
  final double? width;
  final double? borderRadius;

  const CustomTextButton({
    super.key,
    required this.child,
    required this.onPress,
    this.backgroundColor,
    this.width,
    this.borderRadius,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? context.screenWidth * .9,
      child: TextButton(
        onPressed: () {
          widget.onPress();
          //_moveCameraToMyLocation();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(widget.backgroundColor ?? AppColors.white),
          shape: MaterialStatePropertyAll(
            ContinuousRectangleBorder(
                side: const BorderSide(color: AppColors.primaryColor), borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r)),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
