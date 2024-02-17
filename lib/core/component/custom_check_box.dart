import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class CustomCheckBox extends StatefulWidget {
  final bool borderEnable;
  final bool? checkBox;
  final void Function()? onTap;
  final double? paddingIcon;
  final double? borderRadius;
  final double? widthBorder;
  final Color? fillFalseValue;
  final Color? fillTrueValue;
  final Color? borderColor;
  final String? textValue;

  const CustomCheckBox({
    super.key,
    this.borderEnable = true,
    this.fillFalseValue,
    this.fillTrueValue,
    this.paddingIcon,
    this.borderColor,
    this.widthBorder,
    this.textValue,
    this.borderRadius,
    this.onTap,
    this.checkBox = false,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!.call();
        }
      },
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(widget.paddingIcon ?? 8).w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular((widget.borderRadius ?? 8).r),
              color: widget.checkBox! ? widget.fillTrueValue ?? AppColors.primaryColor : widget.fillFalseValue ?? AppColors.white,
              border: Border.all(
                color: widget.borderEnable ? widget.borderColor ?? AppColors.cBorderDecoration : AppColors.transparent,
                width: widget.widthBorder ?? 1,
              ),
            ),
            child: SvgPicture.asset(
              Assets.checkBoxTrue,
              width: context.screenWidth * .03,
              colorFilter: ColorFilter.mode(widget.checkBox! ? AppColors.white : AppColors.transparent, BlendMode.srcIn),
            ),
          ),
          if (widget.textValue != null) 10.ESW(),
          Text(
            widget.textValue ?? '',
            style: Styles.style12400.copyWith(color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
