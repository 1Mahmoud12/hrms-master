import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/utils/extensions.dart';
import 'package:flutter/material.dart';

class MessagesCustomerScreen extends StatelessWidget {
  const MessagesCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support',
          style: Styles.styleHeader,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.screenHeight * .02),
        children: [],
      ),
    );
  }
}
