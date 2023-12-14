import 'package:cnattendance/provider/requestpaidprovider.dart';
import 'package:cnattendance/screen/RequestScreen/Showallrequest.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShowAllpaidRequest extends StatefulWidget {
  const ShowAllpaidRequest({super.key});

  @override
  State<ShowAllpaidRequest> createState() => _ShowAllpaidRequestState();
}

class _ShowAllpaidRequestState extends State<ShowAllpaidRequest> {
  @override
  void initState() {
    super.initState();
    initialState();
  }

  Future<String> initialState() async {
    final leaveProvider =
        Provider.of<RequestPaidProvider>(context, listen: false);
    // ignore: unused_local_variable
    final leaveData = await leaveProvider.getRequestDetail();

    if (!mounted) {
      return 'Loaded';
    }
    setState(() {});
    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RequestPaidProvider>(context);
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
            'Paid_request'.tr,
            style: const TextStyle(
              color: Color(0xff635F54),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
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
                      itemCount: model.PaidrequestList.length,
                      itemBuilder: (context, index) {
                        final Name = model.PaidrequestList[index]['request_type']
                            ['name'];
                        final date = model.PaidrequestList[index]
                            ['leave_requested_date'];
                        final status = model.PaidrequestList[index]['status'];
                        final desc = model.PaidrequestList[index]['reasons'];

                        return Container(
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
                ],
              ),
            ),
          ),
        ),),
      ),
    );
  }
}
