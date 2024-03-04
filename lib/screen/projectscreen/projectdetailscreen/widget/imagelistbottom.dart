import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/cubit.dart';
import 'package:cnattendance/screen/employer/allProject/presentation/manager/overViewProjectBloc/state.dart';
import 'package:cnattendance/screen/projectscreen/projectdetailscreen/projectdetailcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';
import 'package:get/get.dart';

class ItemListBottom extends StatelessWidget {
  const ItemListBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectDetailController model = Get.find();
    final attachments = <Attachment>[];

    for (final attachment in model.project.value.attachment) {
      if (attachment.type == 'image') {
        attachments.add(attachment);
      }
    }

    return BlocProvider(
      create: (context) => OverViewProjectCubit(),
      child: BlocBuilder<OverViewProjectCubit, OverViewState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(5),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            children: List.generate(attachments.length, (index) {
              final attachment = attachments[index];
              return GestureDetector(
                onTap: () {
                  final imageProvider = Image.network(
                    attachment.url,
                  ).image;
                  showImageViewer(
                    context,
                    imageProvider,
                    swipeDismissible: true,
                    onViewerDismissed: () {
                      print('dismissed');
                    },
                  );
                },
                child: Stack(
                  children: [
                    Image.network(
                      attachment.url,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          model.launchUrls(attachment.url);
                        },
                        child: const Card(
                          elevation: 0,
                          color: Colors.blueAccent,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100.h,
                      right: 120.w,
                      child: GestureDetector(
                        onTap: () async {
                          attachments.removeAt(index);
                          model.project.value.attachment.removeAt(index);
                          await OverViewProjectCubit.of(context)
                              .removePicture(index: index, attachmentId: model.project.value.attachment[index].id.toString());
                        },
                        child: const Card(
                          elevation: 0,
                          color: Colors.red,
                          shape: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
