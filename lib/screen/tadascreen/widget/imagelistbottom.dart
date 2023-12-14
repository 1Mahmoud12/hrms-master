import 'package:cnattendance/model/attachment.dart';
import 'package:flutter/material.dart';
import 'package:gallery_image_viewer/gallery_image_viewer.dart';

class ItemListBottom extends StatelessWidget {
  List<Attachment> attachments;

  ItemListBottom(this.attachments, {super.key});
  @override
  Widget build(BuildContext context) {
    final attachList = <Attachment>[];
    for (final attach in attachments) {
      if (attach.type == 'image') {
        attachList.add(attach);
      }
    }
    return Container(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: List.generate(attachList.length, (index) {
          final Attachment item = attachList[index];
          return GestureDetector(
            onTap: () {
              final imageProvider = Image.network(item.url).image;
              showImageViewer(
                context,
                imageProvider,
                swipeDismissible: true,
                onViewerDismissed: () {
                  debugPrint('dismissed');
                },
              );
            },
            child: Stack(
              children: [
                Image.network(
                  item.url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      //TODO: DOWNLoad Files

                      /* FileDownloader.downloadFile(
                            url: "https://media.geeksforgeek.org/wp-content/uploads/20201210102727/Screenshot708.jpg",
                            name: DateTime.now().millisecondsSinceEpoch.toString(),
                            onProgress: (fileName, progress) {
                              print(progress);
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    leading: Container(height: double.infinity,child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Downloading"),
                                    subtitle: Text("${fileName} is downloading",style: TextStyle(color: Colors.grey),),
                                  ),
                                ),
                                context: NavigationService.navigatorKey.currentState!.context,
                              );
                            },
                            onDownloadCompleted: (String path) {
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    leading: Container(height: double.infinity,child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Downloaded"),
                                    subtitle: Text("Download completed",style: TextStyle(color: Colors.grey),),
                                  ),
                                ),
                                context: NavigationService.navigatorKey.currentState!.context,
                              );
                            },
                            onDownloadError: (String error) {
                              print('DOWNLOAD ERROR: $error');
                              InAppNotification.show(
                                child: Card(
                                  margin: const EdgeInsets.all(15),
                                  child: ListTile(
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    leading: Container(height: double.infinity,child: Icon(Icons.download)),
                                    iconColor: HexColor("#011754"),
                                    textColor: HexColor("#011754"),
                                    minVerticalPadding: 10,
                                    minLeadingWidth: 0,
                                    tileColor: Colors.white,
                                    title: Text("Failed"),
                                    subtitle: Text("File Download Failed",style: TextStyle(color: Colors.grey),),
                                  ),
                                ),
                                context: NavigationService.navigatorKey.currentState!.context,
                              );
                            });*/
                    },
                    child: const Card(
                      elevation: 0,
                      color: Colors.black,
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
              ],
            ),
          );
        }),
      ),
    );
  }
}
