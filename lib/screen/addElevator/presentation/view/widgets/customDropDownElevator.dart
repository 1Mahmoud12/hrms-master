import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenuElevator extends StatefulWidget {
  final String? selectedItem;
  final List<String> items;

  final String? type;
  final int? index;

  const CustomDropDownMenuElevator({super.key, required this.selectedItem, required this.items, this.type, this.index});

  @override
  State<CustomDropDownMenuElevator> createState() => _CustomDropDownMenuElevatorState();
}

class _CustomDropDownMenuElevatorState extends State<CustomDropDownMenuElevator> {
  String newSelected = '';

  @override
  void initState() {
    // TODO: implement initState
    newSelected = widget.selectedItem!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r), color: AppColors.cFillColorDropDownButton, border: Border.all(color: Color(0xffF5F6FA))),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: DropdownButton<String>(
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
          child: Text(newSelected),
        ),
        onChanged: (String? newValue) {
          if (ElevatorDropDown.Elevator_type.name == widget.type) {
            MainBlocElevatorCubit.of(context).changeElevatorType(elevatorTypeSelected: newValue!);
          } else if (ElevatorDropDown.Elevator_Subtype.name == widget.type) {
            MainBlocElevatorCubit.of(context).changeElevatorSubtype(elevatorSubTypeSelected: newValue!);
          } else {
            MainBlocElevatorCubit.of(context).changeElevatorOrderType(elevatorOrderSelected: newValue!);
          }
          newSelected = newValue;

          if (MainBlocElevatorCubit.of(context).elevator.length - 1 < widget.index!) {
            MainBlocElevatorCubit.of(context).elevator.add({widget.type!: newValue});
          } else {
            MainBlocElevatorCubit.of(context).elevator[widget.index!][widget.type!] = newValue;
          }
          debugPrint('elevator ${MainBlocElevatorCubit.of(context).elevator}');
        },
        isExpanded: true,
        borderRadius: BorderRadius.circular(15.r),
        autofocus: true,
        focusColor: AppColors.primaryColor,
        dropdownColor: AppColors.greyWhite,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Container(
              // constraints: BoxConstraints(maxWidth: 120.w),
              // width: 120.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0).w,
                child: Text(item, style: Styles.style12400, overflow: TextOverflow.ellipsis),
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
