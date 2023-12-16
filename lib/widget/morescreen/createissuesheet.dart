import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateIssueSheet extends StatefulWidget {
  const CreateIssueSheet({super.key});

  @override
  State<StatefulWidget> createState() => CreateIssueSheetState();
}

class CreateIssueSheetState extends State<CreateIssueSheet> {
  bool isLoading = false;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  void dismissLoader() {
    setState(() {
      EasyLoading.dismiss();
    });
  }

  void showLoader() {
    setState(() {
      EasyLoading.show(
        status: 'Requesting...',
        maskType: EasyLoadingMaskType.black,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
          left: 20,
          right: 20,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Issue Ticket',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              TextField(
                controller: title,
                style: const TextStyle(color: Colors.white),
                //editing controller of this TextField
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.note_alt_rounded, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              gaps(10),
              TextField(
                textAlignVertical: TextAlignVertical.top,
                controller: description,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                //editing controller of this TextField
                cursorColor: Colors.white,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Description',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.edit_note, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              gaps(20),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff036eb7),
                    padding: EdgeInsets.zero,
                    shape: ButtonBorder(),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Submit Ticket',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gaps(double value) {
    return SizedBox(
      height: value,
    );
  }
}
