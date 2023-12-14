import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/core/theme/styles.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class MissionFlip extends StatelessWidget {
  final String backImage;
  final IconData misIcon;
  final String misHeading;
  final String misPara;
  final String misBackPara;

  const MissionFlip({
    super.key,
    required this.backImage,
    required this.misIcon,
    required this.misBackPara,
    required this.misHeading,
    required this.misPara,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: FlipCard(
        fill: Fill.fillBack,
        // Fill the back side of the card to make in the same size as the front.
        //direction: FlipDirection.HORIZONTAL,
        // default
        //side: CardSide.FRONT,
        // The side to initially display.
        front: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed

            image: DecorationImage(
              colorFilter: const ColorFilter.mode(AppColors.scaffoldBackGround, BlendMode.softLight),

              image: AssetImage(backImage), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    misIcon,
                    color: AppColors.white,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    misHeading,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    misPara,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        back: Container(
          width: MediaQuery.of(context).size.width * .9,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
            color: AppColors.white,
          ),
          child: Center(
            child: Text(
              misBackPara,
              style: Styles.style12400,
            ),
          ),
        ),
      ),
    );
  }
}
