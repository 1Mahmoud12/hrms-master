import 'package:cnattendance/model/team.dart';
import 'package:cnattendance/provider/teamsheetprovider.dart';
import 'package:cnattendance/screen/profile/employeedetailscreen.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamSheetScreen extends StatelessWidget {
  static const routeName = '/teamsheet';

  const TeamSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TeamSheetProvider(),
      child: const TeamSheet(),
    );
  }
}

class TeamSheet extends StatefulWidget {
  const TeamSheet({super.key});

  @override
  State<StatefulWidget> createState() => TeamSheetState();
}

class TeamSheetState extends State<TeamSheet> {
  bool initialState = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (initialState) {
      getTeam();
      initialState = false;
    }
    super.didChangeDependencies();
  }

  Future<String> getTeam() async {
    setState(() async {
      isLoading = true;
      EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
      await Provider.of<TeamSheetProvider>(context, listen: false).getTeam();
      isLoading = false;
      EasyLoading.dismiss();
    });

    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeamSheetProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(provider.company['name']!),
            elevation: 0,
          ),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                return getTeam();
              },
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  itemCount: provider.teamList.length,
                  itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: teamCard(provider.teamList[i]),),),
            ),
          ),
        ),
      ),
    );
  }

  Widget teamCard(Team teamList) {
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: Colors.white10,
      child: InkWell(
        onTap: () {
          Get.to(const EmployeeDetailScreen(),
              arguments: {'employeeId': teamList.id.toString()},);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            teamList.active == '1' ? Colors.green : Colors.grey,
                        width: 2,),),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    teamList.avatar,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        teamList.name,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      Text(teamList.post,
                          style: const TextStyle(color: Colors.white70),),
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final url = Uri.parse('tel:${teamList.phone}');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),),
              IconButton(
                  onPressed: () async {
                    final url = Uri(scheme: 'sms', path: teamList.phone);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  icon: const Icon(
                    Icons.message,
                    color: Colors.white,
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
