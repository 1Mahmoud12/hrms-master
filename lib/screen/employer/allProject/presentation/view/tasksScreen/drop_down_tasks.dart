import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/model/member.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/tasksBloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenuTasks extends StatefulWidget {
  final Member? selectedItem;
  final List<Member> items;
  final double? width;

  const CustomDropDownMenuTasks({
    super.key,
    required this.selectedItem,
    required this.items,
    this.width,
  });

  @override
  State<CustomDropDownMenuTasks> createState() => _CustomDropDownMenuTasksState();
}

class _CustomDropDownMenuTasksState extends State<CustomDropDownMenuTasks> {
  Member newSelected = Member(-1, 'Name Engineer', 'image');

  @override
  void initState() {
    // TODO: implement initState
    newSelected = widget.selectedItem!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white, border: Border.all(color: Color(0xffF5F6FA))),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: DropdownButton<Member>(
        underline: Container(),
        icon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.arrow_forward_ios,
            //size: 25.w,
          ),
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 10).w,
          child: Text(newSelected.name),
        ),
        onChanged: (Member? newValue) {
          newSelected = newValue!;
          TasksCubit.of(context).addSelected(newSelected: newValue);
          setState(() {});
        },
        isExpanded: true,
        borderRadius: BorderRadius.circular(15.r),
        autofocus: true,
        focusColor: AppColors.primaryColor,
        dropdownColor: AppColors.greyWhite,
        items: widget.items.map((Member item) {
          return DropdownMenuItem<Member>(
            value: item,
            child: Container(
              // constraints: BoxConstraints(maxWidth: 120.w),
              // width: 120.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0).w,
                child: Text(item.name, style: Styles.style12400, overflow: TextOverflow.ellipsis),
              ),
            ),
            onTap: () {
              //debugPrint(widget.selectedItem);
            },
          );
        }).toList(),
      ),
    );
  }
}
