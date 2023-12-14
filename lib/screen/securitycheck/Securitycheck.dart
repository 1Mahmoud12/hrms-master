import 'package:cnattendance/core/theme/styles.dart';
import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/utils/authservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SecurityCheckScreen extends StatefulWidget {
  const SecurityCheckScreen({super.key});

  @override
  State<SecurityCheckScreen> createState() => _SecurityCheckScreenState();
}

class _SecurityCheckScreenState extends State<SecurityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Securitiy'.tr,
          style: Styles.styleHeader,
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: provider.getUserAuth(),
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              dense: true,
                              minLeadingWidth: 5,
                              leading: const Icon(
                                Icons.security,
                                color: Color(0xff635F54),
                              ),
                              title: Text(
                                'Securitiy'.tr,
                                style: const TextStyle(color: Color(0xff635F54), fontSize: 15),
                              ),
                              trailing: Switch(
                                value: snapshot.data!,
                                onChanged: (value) async {
                                  final bool isAuthenticated = await AuthService.authenticateUser();
                                  if (isAuthenticated) {
                                    setState(() {
                                      provider.saveAuth(value: value);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Either no biometric is enrolled or biometric did not match'),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                activeTrackColor: Colors.blueAccent,
                                activeColor: Colors.lightBlue,
                              ),
                              selected: true,
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.white24,
                              indent: 15,
                              endIndent: 15,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox(
                        height: 0,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
