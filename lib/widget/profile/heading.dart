import 'dart:io';

import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/core/utils/constants.dart';
import 'package:cnattendance/provider/profileprovider.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Heading extends StatefulWidget {
  const Heading({super.key});

  @override
  State<StatefulWidget> createState() => HeadingState();
}

class HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    final provider = Provider.of<ProfileProvider>(context, listen: false);
    final profile = Provider.of<ProfileProvider>(context).profile;
    debugPrint('Now Please ==>${profile.avatar == ''}');
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 500);
                if (image != null) {
                  EasyLoading.show(status: 'Changing....', maskType: EasyLoadingMaskType.black);
                  try {
                    isLoading = true;
                    await provider.updateProfile('', '', '', '', '', '', File(image.path));
                  } catch (e) {
                    showToast(e.toString());
                  }
                  isLoading = false;
                  EasyLoading.dismiss();
                  setState(() {});
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: profile.avatar == '' ? NetworkImage(userCache!.avatar!) : NetworkImage(profile.avatar),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    color: Colors.black38,
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Change',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                profile.name,
                style: Styles.style18700,
              ),
            ),
            /*Text(
              profile.post,
              style: Styles.style14500.copyWith(color: AppColors.subTextColor),
            ),*/
          ],
        ),
      ),
    );
  }
}
