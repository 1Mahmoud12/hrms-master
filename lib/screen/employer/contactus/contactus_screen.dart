import 'package:cnattendance/core/theme/color_constraint.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: AppColors.scaffoldBackGround,
      ),
      body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView(
                children: const [
                  ContactComp(
                    contheading: 'Unified Number',
                    conticon: Icons.phone,
                    contpara: '920033110',
                  ),
                  ContactComp(
                    contheading: 'Email',
                    conticon: Icons.mail,
                    contpara: 'info@darbayat.sa',
                  ),
                  ContactComp(
                    contheading: 'Address',
                    conticon: Icons.home,
                    contpara: 'Wag Valley, Al Malqa District, Riyadh 13524, KSA',
                  ),
                ],
              ),),),
    );
  }
}

class ContactComp extends StatelessWidget {
  final conticon;
  final contheading;
  final contpara;

  const ContactComp({super.key, required this.conticon, required this.contheading, required this.contpara});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
              color: AppColors.scaffoldBackGround.withOpacity(0.8),),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  conticon,
                  color: AppColors.white,
                  size: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(contheading,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),),
                Text(contpara,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),),
              ],
            ),),
          ),),
    );
  }
}
