import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/companyrulesprovider.dart';
import 'package:cnattendance/widget/companyrulesscreen/ruleslist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CompanyRulesScreen extends StatelessWidget {
  const CompanyRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => CompanyRulesProvider(), child: const CompanyRules());
  }
}

class CompanyRules extends StatefulWidget {
  const CompanyRules({super.key});

  @override
  State<StatefulWidget> createState() => CompanyRulesState();
}

class CompanyRulesState extends State<CompanyRules> {
  bool initial = true;

  @override
  void didChangeDependencies() {
    if (initial) {
      Provider.of<CompanyRulesProvider>(context).getContent();
      initial = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Companyrule'.tr,
          style: Styles.styleHeader,
        ),
        elevation: 0,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: RulesList(),
      ),
    );
  }
}
