import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/teamsheetprovider.dart';
import 'package:cnattendance/screen/TeamsheetScreen/team_sheet_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TeamSheetScreenNew extends StatelessWidget {
  const TeamSheetScreenNew({super.key});

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
    isLoading = true;
    // EasyLoading.show(status: 'Loading', maskType: EasyLoadingMaskType.black);
    await Provider.of<TeamSheetProvider>(context, listen: false).getTeam();
    isLoading = false;
    // EasyLoading.dismiss();
    setState(() {});

    return 'Loaded';
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeamSheetProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Team_Sheet'.tr,
            style: Styles.styleHeader,
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () {
              return getTeam();
            },
            child: ListView.builder(
              itemBuilder: (context, index) => TeamSheetCard(teamList: provider.teamList[index]),
              itemCount: provider.teamList.length,
              /*children: [
                */ /*GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.teamList.length,
                  // padding: EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2.2 / 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: provider.teamList[i],
                    child: ,
                  ),
                ),*/ /*
              ],*/
            ),
          ),
        ),
      ),
    );
  }
}
