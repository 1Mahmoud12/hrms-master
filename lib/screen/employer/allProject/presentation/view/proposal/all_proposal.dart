import 'package:cnattendance/core/component/empty_widget.dart';
import 'package:cnattendance/core/routes/app_route.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/proposalCubit/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/proposalCubit/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../../../core/theme/color_constraint.dart';

class ProposalScreen extends StatelessWidget {
  const ProposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProposalCubit()..getAllProposals(context: context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Proposal',
            style: Styles.styleHeader.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<ProposalCubit, ProposalState>(
          builder: (context, state) => Column(
            children: [
              if (state is ProposalLoadingState)
                SizedBox(
                    height: context.screenHeight - Scaffold.of(context).appBarMaxHeight!, child: const Center(child: CircularProgressIndicator()))
              else if (state is ProposalErrorState)
                Center(child: Text(state.error))
              else if (allProposalsModelCache != null && allProposalsModelCache!.data != null)
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(context.screenWidth * .02),
                    children: [
                      ...List.generate(
                        allProposalsModelCache!.data!.requests!.length,
                        (index) => InkWell(
                          onTap: () async {
                            await ProposalCubit.of(context)
                                .getOneProposals(context: context, idProposal: allProposalsModelCache!.data!.requests![index].propasalId!);
                            final arguments = {
                              'index': index,
                              'formRequestId': allProposalsModelCache!.data!.requests![index].propasalId,
                              'oneProposal': ProposalCubit.of(context).proposalOneModel,
                              // 'idProducts': allProposalsModelCache!.data!.requests![index].formData!.productsValue,
                            };
                            if (ProposalCubit.of(context).proposalOneModel != null && ProposalCubit.of(context).proposalOneModel!.data != null) {
                              Navigator.pushNamed(context, AppRoute.detailsProposalScreen, arguments: arguments);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.all(context.screenWidth * .02),
                            padding: EdgeInsets.all(context.screenWidth * .02),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: AppColors.white),
                            child: state is ProposalLoadingState
                                ? Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  )
                                : state is ProposalErrorState
                                    ? Center(child: Text(state.error))
                                    : Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            constraints: BoxConstraints(maxWidth: context.screenWidth * .4),
                                            padding: const EdgeInsets.all(10),
                                            decoration:
                                                BoxDecoration(color: AppColors.cBackGroundIconButton, borderRadius: BorderRadius.circular(10.r)),
                                            child: SvgPicture.asset(Assets.stepOne),
                                          ),
                                          10.ESW(),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allProposalsModelCache!.data!.requests![index].formData!.userNameValue ?? '',
                                                      style: Styles.style14500.copyWith(fontSize: 15.sp, color: AppColors.textColorTextFormField),
                                                    ),
                                                    5.ESH(),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.my_location_sharp,
                                                          color: AppColors.primaryColor,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          allProposalsModelCache!.data!.requests![index].formData!.userAddressValue ?? '',
                                                          style: Styles.style18700.copyWith(color: AppColors.grey, fontSize: 12.sp),
                                                        ),
                                                      ],
                                                    ),
                                                    5.ESH(),
                                                    /*    SizedBox(
                                      width: context.screenWidth * .5,
                                      child: Text(ProposalCubit.of(context).steps[index]['description']),
                                    ),
                                    5.ESH(),*/
                                                    /*
                                      */
                                                    /*SizedBox(
                                      height: context.screenHeight * .002,
                                      width: context.screenWidth * .5,
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          trackShape: CustomTrackShape(),
                                          //thumbColor: Colors.transparent,
                                          thumbShape: SliderComponentShape.noThumb,
                                          trackHeight: 2,
                                        ),
                                        child: Slider(
                                          value: double.parse(ProposalCubit.of(context).steps[index]['value']) / 100,
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    ),*/
                                                    /*
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                SizedBox(height: context.screenHeight - Scaffold.of(context).appBarMaxHeight!, child: const Center(child: EmptyWidget()))
            ],
          ),
        ),
      ),
    );
  }
}
