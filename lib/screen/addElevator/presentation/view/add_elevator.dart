import 'package:cnattendance/core/component/buttons/custom_text_button.dart';
import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/cubit.dart';
import 'package:cnattendance/screen/addElevator/presentation/manager/mainBlocElevator/state.dart';
import 'package:cnattendance/screen/addElevator/presentation/view/widgets/customDropDownElevator.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddElevator extends StatefulWidget {
  const AddElevator({super.key});

  @override
  State<AddElevator> createState() => _AddElevatorState();
}

class _AddElevatorState extends State<AddElevator> {
  PageController pageController = PageController();

  bool validate({required MainBlocElevatorCubit cubit}) {
    if (cubit.elevatorType != 'Elevator type' && cubit.elevatorSubtype != 'Elevator Subtype' && cubit.orderType != 'Order Type') return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = MainBlocElevatorCubit.of(context);

    final arguments = context.getArguments;
    final String numberElevators = arguments['numberElevators'];
    debugPrint('numberElevators ===> $numberElevators');
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        ...List.generate(
          int.parse(numberElevators),
          (index) => Scaffold(
            appBar: AppBar(
              title: Text(
                'Elevator ${index + 1}',
                style: Styles.styleHeader,
              ),
            ),
            persistentFooterButtons: [
              BlocBuilder<MainBlocElevatorCubit, MainBlocElevatorState>(
                builder: (context, state) => CustomTextButton(
                  backgroundColor: AppColors.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.addMaintenance),
                      5.ESW(),
                      Text(
                        'Continue',
                        style: Styles.style16700.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                  onPress: () {
                    debugPrint('orderType ${cubit.orderType}');
                    debugPrint('elevatorSubtype ${cubit.elevatorSubtype}');
                    debugPrint('elevatorType ${cubit.elevatorType}');
                    if (validate(cubit: cubit)) {
                      pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                    } else {
                      showToast('You must fill all fields');
                    }
                  },
                ),
              ),
            ],
            body: ListView(
              padding: const EdgeInsets.all(24).w,
              children: [
                BlocBuilder<MainBlocElevatorCubit, MainBlocElevatorState>(
                  builder: (context, state) => CustomDropDownMenuElevator(
                    selectedItem: cubit.elevatorType,
                    items: cubit.elevatorTypeList,
                    type: ElevatorDropDown.Elevator_type.name,
                    index: index,
                  ),
                ),
                BlocBuilder<MainBlocElevatorCubit, MainBlocElevatorState>(
                  builder: (context, state) => CustomDropDownMenuElevator(
                    selectedItem: cubit.elevatorSubtype,
                    items: cubit.elevatorTypeList,
                    type: ElevatorDropDown.Elevator_Subtype.name,
                    index: index,
                  ),
                ),
                BlocBuilder<MainBlocElevatorCubit, MainBlocElevatorState>(
                  builder: (context, state) => CustomDropDownMenuElevator(
                    selectedItem: cubit.orderType,
                    items: cubit.elevatorTypeList,
                    type: ElevatorDropDown.Order_Type.name,
                    index: index,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.screenWidth * .4,
                      child: CustomTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Passengers Number',
                        fontSizeHintText: 13,
                        textInputType: TextInputType.number,
                        fillColor: AppColors.cFillColorDropDownButton,
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth * .4,
                      child: CustomTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Floors Number',
                        fontSizeHintText: 13,
                        textInputType: TextInputType.number,
                        fillColor: AppColors.cFillColorDropDownButton,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cabin Area',
                    style: Styles.style18700.copyWith(color: Colors.black, fontSize: 20.sp),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.screenWidth * .4,
                      child: CustomTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Height',
                        textInputType: TextInputType.number,
                        fillColor: AppColors.cFillColorDropDownButton,
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth * .4,
                      child: CustomTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Width',
                        textInputType: TextInputType.number,
                        fillColor: AppColors.cFillColorDropDownButton,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: context.screenWidth * .86,
                      child: CustomTextFormField(
                        controller: TextEditingController(),
                        hintText: 'Stairwell Depth',
                        textInputType: TextInputType.number,
                        fillColor: AppColors.cFillColorDropDownButton,
                      ),
                    ),
                  ],
                ),
              ].paddingDirectional(bottom: 10.h),
            ),
          ),
        ),
      ],
    );
  }
}
