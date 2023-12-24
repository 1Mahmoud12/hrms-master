import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imagesUrl = [
      'https://images.pexels.com/photos/4254891/pexels-photo-4254891.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/4390582/pexels-photo-4390582.jpeg?auto=compress&cs=tinysrgb&w=600',
      'https://images.pexels.com/photos/18533100/pexels-photo-18533100/free-photo-of-spiral-staircase-and-elevators.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'https://images.pexels.com/photos/12407009/pexels-photo-12407009.jpeg?auto=compress&cs=tinysrgb&w=600',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rak Elevators',
          style: Styles.styleHeader,
        ),
        backgroundColor: AppColors.scaffoldBackGround,
      ),
      body: Column(
        children: [
          FlipCard(
            front: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(Assets.cardPlans),
                Text(
                  'Crafting Connected Future',
                  style: Styles.style18700.copyWith(color: AppColors.white),
                ),
              ],
            ),
            back: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r), color: AppColors.white),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'At ElevateCare Solutions, we stand as a beacon of reliability, committed to elevating your experience through unparalleled elevator maintenance services. As a forward-thinking maintenance company, we blend the art of development with the ethos of hard work, ensuring your vertical transportation systems are not just maintained but transformed into assets that truly elevate your spaces.',
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.screenHeight * .4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: context.screenHeight * .25,
                      width: context.screenWidth * .5,
                      imageUrl: imagesUrl[index],
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: AppColors.primaryColor),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              itemCount: imagesUrl.length,
            ),
          ),
        ],
      ),
    );
  }
}
