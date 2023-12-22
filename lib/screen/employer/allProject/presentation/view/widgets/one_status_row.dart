import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OneStatusRow extends StatelessWidget {
  final bool button;
  final Function? onPress;
  final String assetsName;
  final Widget? anotherWidget;
  final bool anotherWidgetBool;
  final String nameRow;

  const OneStatusRow({
    super.key,
    required this.button,
    this.onPress,
    required this.assetsName,
    this.anotherWidget,
    this.anotherWidgetBool = true,
    required this.nameRow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (button) {
          onPress!();
        }
      },
      child: Container(
        height: context.screenHeight * .08,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.all(10.w),
              child: SvgPicture.asset(
                assetsName,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
            20.ESW(),
            Text(
              nameRow,
              style: Styles.style14400.copyWith(color: AppColors.textColorTextFormField),
            ),
            if (anotherWidgetBool) const Spacer(),
            if (anotherWidgetBool) anotherWidget ?? Container(),
            const Spacer(),
            if (button) SvgPicture.asset(Assets.arrowIOS),
          ],
        ),
      ),
    );
  }
}
