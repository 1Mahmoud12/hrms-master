import 'package:cnattendance/Controller/RequestScreenController.dart';
import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:cnattendance/model/leave.dart';
import 'package:cnattendance/provider/requestleaveprovider.dart';
import 'package:cnattendance/screen/RequestScreen/Showallrequest.dart';
import 'package:cnattendance/utils/endpoints.dart';
import 'package:dropdown_button3/dropdown_button3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  Leave? selectedValue;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initialState();
  }

  Future<String> initialState() async {
    final leaveProvider = Provider.of<RequestProvider>(context, listen: false);
    final leaveData = await leaveProvider.getLeaveType();

    if (!mounted) {
      return 'Loaded';
    }
    if (leaveData.statusCode != 200) {
      showToast(leaveData.message);
    }

    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestProvider>(context);
    final control = Get.put(RequestController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.to(const ShowAllRequest());
              // model.showList();
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: SvgPicture.string(
                  '''
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                      <path d="M3.20258 8.70024H20.7974M2.88539 15.1513C2.37154 13.0819 2.37154 10.9181 2.88539 8.84875C3.55805 6.13983 5.70602 4.04534 8.43056 3.44162L8.88443 3.34105C10.9366 2.88632 13.0634 2.88632 15.1156 3.34105L15.5694 3.44162C18.294 4.04534 20.442 6.13984 21.1146 8.84875C21.6285 10.9182 21.6285 13.0819 21.1146 15.1512C20.442 17.8602 18.294 19.9547 15.5694 20.5584L15.1156 20.659C13.0634 21.1137 10.9366 21.1137 8.88443 20.659L8.43056 20.5584C5.70601 19.9547 3.55805 17.8602 2.88539 15.1513Z" stroke="#635F54" stroke-width="1.5"/>
                      <path d="M7 12L11 12" stroke="#635F54" stroke-width="1.5" stroke-linecap="round"/>
                    </svg>
                    ''',
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ],
        title: Text(
          'create_request'.tr,
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.grey),
                ),
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'SelectrequestType'.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: provider.leaveList
                        .where((element) => element.status)
                        .map(
                          (item) => DropdownMenuItem<Leave>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      selectedValue = value as Leave?;
                      if (selectedValue != null) {
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                    ),
                    iconSize: 25,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: 160,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    buttonElevation: 0,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: Colors.white,
                    ),
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: control.descriptionController,
                maxLength: 500,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 5,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.grey),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field can't be empty";
                  }
                  return null;
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  counterStyle: const TextStyle(color: Colors.white),
                  hintText: 'Description'.tr,
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'AddAttachment'.tr,
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  control.onFileClicked();
                },
                child: const Card(
                  shape: CircleBorder(),
                  color: AppColors.primaryColor,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Obx(
                () => ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: control.fileList.length,
                  itemBuilder: (context, index) {
                    final file = control.fileList[index];
                    return ListTile(
                      title: Text(
                        file.name,
                        style: const TextStyle(color: AppColors.primaryColor),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          control.removeItem(index);
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(29)),
            ),
          ),
          onPressed: () {
            if (selectedValue != null) {
              final DateTime currentDateTime = DateTime.now();

              // Add 5 minutes to the current date and time
              final DateTime newDateTime = currentDateTime.add(const Duration(days: 1));
              final String curr = DateFormat('yyyy-MM-dd HH:mm:ss').format(newDateTime);

              if (control.fileList.isEmpty) {
                Get.snackbar('Required', 'Attachment is required');
              } else {
                control.issueLeave(
                  curr,
                  curr,
                  control.descriptionController.text,
                  selectedValue!.id,
                );

                setState(() {
                  selectedValue!.id = 0;
                });
              }
              // control.descriptionController..clear();
            } else {
              // print(selectedValue!.id);
              Get.snackbar('Required', 'Select Request Type First');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Submit'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
