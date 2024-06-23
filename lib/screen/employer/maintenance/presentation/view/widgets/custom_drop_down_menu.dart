import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/productsNeedTechnicalBloc/cubit.dart';
import 'package:cnattendance/screen/employer/maintenance/presentation/manager/reportBloc/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenuTechnical extends StatefulWidget {
  final String? selectedItem;
  final List<String> items;
  final double? width;
  final ProductsNeedTechnicalBloc cubit;

  const CustomDropDownMenuTechnical({
    super.key,
    required this.selectedItem,
    required this.items,
    this.width,
    required this.cubit,
  });

  @override
  State<CustomDropDownMenuTechnical> createState() =>
      _CustomDropDownMenuTechnicalState();
}

class _CustomDropDownMenuTechnicalState
    extends State<CustomDropDownMenuTechnical> {
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
      width: widget.width ?? MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: AppColors.white,
          border: Border.all(color: const Color(0xffF5F6FA))),
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
          newSelected = newValue!;
          BlocProvider.of<ReportBloc>(context).selectedProduct = newValue;

          ProductsNeedTechnicalBloc.of(context).addProduct(product: newValue);
          debugPrint(newValue);
          setState(() {});
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0).w,
                child: Text(item,
                    style: Styles.style12400, overflow: TextOverflow.ellipsis),
              ),
            ),
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
