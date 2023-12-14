import 'package:cnattendance/provider/requestleaveprovider.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShowAllRequest extends StatefulWidget {
  const ShowAllRequest({super.key});

  @override
  State<ShowAllRequest> createState() => _ShowAllRequestState();
}

class _ShowAllRequestState extends State<ShowAllRequest> {
  @override
  void initState() {
    super.initState();
    initialState();
  }

  Future<String> initialState() async {
    final leaveProvider = Provider.of<RequestProvider>(context, listen: false);
    await leaveProvider.getRequestDetail();

    if (!mounted) {
      return 'Loaded';
    }
    // if (leaveData.statusCode != 200) {
    //   showToast(leaveData.message);
    // }
    setState(() {});
    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RequestProvider>(context);
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Image.asset('assets/icons/backicon.png'),
              ),
            ),
            title: Text(
              'Unpaid_request'.tr,
              style: const TextStyle(
                color: Color(0xff635F54),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,),
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 1,
                    width: Get.width * 1,
                    child: ListView.builder(
                      itemCount: model.requestList.length,
                      itemBuilder: (context, index) {
                        final Name =
                            model.requestList[index]['request_type']['name'];
                        final date =
                            model.requestList[index]['leave_requested_date'];
                        final status = model.requestList[index]['status'];
                        final desc = model.requestList[index]['reasons'];

                        return Container(
                          // child: ListTile(
                          //   title: Text(model.requestList[index]['status']),
                          // ),

                          child: AllRequests(
                              Name: Name,
                              date: date,
                              status: status,
                              from: '',
                              to: '',
                              description: desc,),
                        );
                      },
                    ),
                  ),
                  // AllRequests(
                  //   Name: 'Leave Request',
                  //   to: 'sep 12:pm',
                  //   from: 'sep 10:20pm',
                  //   date: '9-10-2022',
                  //   status: 'Pending',
                  //   description: 'desc',
                  // )
                ],
              ),
            ),
          ),
        ),),
      ),
    );
  }
}

class AllRequests extends StatelessWidget {
  final String Name;
  final String status;
  final String date;
  final String from;
  final String to;
  final String description;
  const AllRequests(
      {super.key,
      required this.Name,
      required this.to,
      required this.from,
      required this.date,
      required this.description,
      required this.status,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            elevation: 0,
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),),),
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: updatesheet(
                  reqType: Name,
                  status: status,
                  date: date,
                  desc: description,
                ),
              );
            },
          );
        },
        child: Container(
          width: Get.width * 0.88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfffff8f8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      Name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$from  $to',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        'Status_underscore'.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(' $status at $date',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class updatesheet extends StatelessWidget {
  String reqType;
  String status;
  String date;
  String desc;
  updatesheet(
      {super.key,
      required this.reqType,
      required this.date,
      required this.desc,
      required this.status,});

  // String? selectedValue;

  // List leaveTypes = [
  //   'Approved',
  //   'Rejected',
  //   'Pending',
  // ];

  @override
  Widget build(BuildContext context) {
    // void _showDialog() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       // Return an AlertDialog or CupertinoAlertDialog for iOS-style dialog
    //       return AlertDialog(
    //         title: Text('Update Request'),
    //         content: Container(
    //           height: Get.height * 0.15,
    //           child: Column(
    //             children: [
    //               Container(
    //                 width: Get.width * 1,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(2.0),
    //                   child: DropdownButtonHideUnderline(
    //                     child: DropdownButton2<String>(
    //                       isExpanded: true,
    //                       hint: Row(
    //                         children: const [
    //                           Expanded(
    //                             child: Text(
    //                               'Select Leave Type',
    //                               style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.bold,
    //                                 color: Colors.black,
    //                               ),
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       items: leaveTypes
    //                           .map((item) => DropdownMenuItem<String>(
    //                                 value: item,
    //                                 child: Text(
    //                                   item,
    //                                   style: const TextStyle(
    //                                     fontSize: 14,
    //                                   ),
    //                                 ),
    //                               ))
    //                           .toList(),
    //                       value: selectedValue,
    //                       onChanged: (value) {
    //                         selectedValue = value;
    //                         print(value);
    //                         if (selectedValue != null) {
    //                           setState(() {});
    //                         }
    //                       },
    //                       icon: const Icon(
    //                         Icons.arrow_forward_ios_outlined,
    //                       ),
    //                       iconSize: 14,
    //                       iconEnabledColor: Colors.black,
    //                       iconDisabledColor: Colors.grey,
    //                       buttonHeight: 50,
    //                       buttonWidth: 160,
    //                       buttonPadding:
    //                           const EdgeInsets.only(left: 14, right: 14),
    //                       buttonDecoration: BoxDecoration(
    //                         borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(10),
    //                             topRight: Radius.circular(10),
    //                             bottomLeft: Radius.circular(10),
    //                             bottomRight: Radius.circular(10)),
    //                         color: Colors.grey,
    //                       ),
    //                       buttonElevation: 0,
    //                       itemHeight: 40,
    //                       itemPadding:
    //                           const EdgeInsets.only(left: 14, right: 14),
    //                       dropdownMaxHeight: 200,
    //                       dropdownPadding: null,
    //                       dropdownDecoration: BoxDecoration(
    //                         borderRadius: BorderRadius.only(
    //                             topLeft: Radius.circular(0),
    //                             topRight: Radius.circular(10),
    //                             bottomLeft: Radius.circular(10),
    //                             bottomRight: Radius.circular(10)),
    //                         color: Colors.white,
    //                       ),
    //                       dropdownElevation: 8,
    //                       scrollbarRadius: const Radius.circular(40),
    //                       scrollbarThickness: 6,
    //                       scrollbarAlwaysShow: true,
    //                       offset: const Offset(0, 0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 padding: EdgeInsets.only(left: 0),
    //                 child: TextButton(
    //                   style: TextButton.styleFrom(
    //                     backgroundColor: HexColor("#635f54"),
    //                     padding: EdgeInsets.zero,
    //                     shape: RoundedRectangleBorder(
    //                         borderRadius:
    //                             BorderRadius.all(Radius.circular(29))),
    //                   ),
    //                   onPressed: () {},
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(3.0),
    //                     child: Text(
    //                       'Update',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 14,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: Text('Close'),
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Request_info'.tr,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Colors.black,
                      ),),
                ],
              ),
              Table(
                columnWidths: <int, TableColumnWidth>{
                  0: FixedColumnWidth(
                      Get.width * 0.45,), // Custom width for column 0
                  1: FixedColumnWidth(
                      Get.width * 0.45,), // Custom width for column 1
                },
                border: TableBorder
                    .all(), // Allows to add a border decoration around your table
                children: [
                  TableRow(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Request_Type'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(reqType),
                      ),),
                    ],
                  ),
                  TableRow(children: [
                    SizedBox(
                      width: Get.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Date'.tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        date,
                        style: const TextStyle(),
                      ),
                    ),),
                  ],),
                  TableRow(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Status'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          status,
                          style: const TextStyle(),
                        ),
                      ),),
                    ],
                  ),
                  TableRow(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Description'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          desc,
                          style: const TextStyle(),
                        ),
                      ),),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.only(left: 5),
              //   child: TextButton(
              //     style: TextButton.styleFrom(
              //       backgroundColor: HexColor("#635f54"),
              //       padding: EdgeInsets.zero,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(29))),
              //     ),
              //     onPressed: () {
              //       // _showDialog();
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Text(
              //         'Update Status',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
