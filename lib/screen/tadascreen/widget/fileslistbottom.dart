import 'package:cnattendance/model/attachment.dart';
import 'package:flutter/material.dart';

class FilesListBottom extends StatelessWidget {
  List<Attachment> attachments;

  FilesListBottom(this.attachments, {super.key});
  @override
  Widget build(BuildContext context) {
    final attachList = <Attachment>[];
    for(final attach in attachments){
      if(attach.type == 'file'){
        attachList.add(attach);
      }
    }
    return Container(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: attachList.length,
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final Attachment item = attachList[index];
            return Card(
                elevation: 0,
                color: Colors.white12,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.url,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),);
          },
        ),);
  }
}
