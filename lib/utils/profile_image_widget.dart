import 'package:cnattendance/core/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      userCache!.avatar ?? '',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/dummy_avatar.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
