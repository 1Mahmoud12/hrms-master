import 'package:cnattendance/core/component/custom_text_form_field.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/commentBLoc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/commentBLoc/state.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:cnattendance/utils/screen_spaces_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Comments extends StatelessWidget {
  final int newComments;

  const Comments({super.key, required this.newComments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).w,
      child: Column(
        children: [
          Row(
            children: [
              BlocBuilder<CommentCubit, CommentState>(
                builder: (context, state) => Text(
                  'Comments (${CommentCubit.of(context).comments.length})',
                  style: Styles.style16700,
                ),
              ),
              const Spacer(),
              Text(
                'See All',
                style: Styles.style16700.copyWith(color: AppColors.primaryColor),
              ),
            ],
          ),
          10.ESH(),
          SizedBox(
            // height: context.screenHeight * .3,
            child: BlocBuilder<CommentCubit, CommentState>(
              builder: (context, state) => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r)),
                  padding: EdgeInsets.all(10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Assets.personal),
                              10.ESW(),
                              Text(
                                'Name person',
                                style: Styles.style14500,
                              ),
                            ],
                          ),
                          10.ESH(),
                          Text(
                            CommentCubit.of(context).comments[index],
                            style: Styles.style12400.copyWith(color: AppColors.textColorTextFormField),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => CommentCubit.of(context).deleteComment(index: index),
                        child: SvgPicture.asset(
                          Assets.trash,
                          width: context.screenWidth * .045,
                          colorFilter: ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                        ),
                      )
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => 10.ESH(),
                itemCount: CommentCubit.of(context).comments.length,
              ),
            ),
          ),
          BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) => SizedBox(
              height: context.screenHeight * .1,
              child: CustomTextFormField(
                controller: CommentCubit.of(context).commentController,
                hintText: 'Add comment',
                fillColor: AppColors.white,
                suffixIcon: IconButton(
                  onPressed: () {
                    CommentCubit.of(context).addComment();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ].paddingDirectional(top: 10.h),
      ),
    );
  }
}
