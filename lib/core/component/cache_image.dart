import 'package:cached_network_image/cached_network_image.dart';
import 'package:cnattendance/utils/assets.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final bool circle;
  final bool? profileImage;
  final String imageUrl;

  const CacheImage({
    super.key,
    this.width,
    this.height,
    this.boxFit,
    this.circle = false,
    this.profileImage = true,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: circle ? Clip.antiAlias : Clip.none,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: boxFit ?? BoxFit.cover,
        errorWidget: (context, url, error) => Center(
          child: profileImage!
              ? Image.asset(
                  'assets/images/dummy_avatar.png',
                  width: width,
                  height: height,
                  fit: boxFit ?? BoxFit.cover,
                )
              : Image.asset(
                  Assets.temElevator,
                  width: width,
                  height: height,
                  fit: boxFit ?? BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
