import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorWidgetScreen extends StatelessWidget {
  final String message;
  final Function onPress;
  const ErrorWidgetScreen({super.key, required this.message, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.sizeOf(context).width * .6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            Lottie.asset('assets/animation/error.json'),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            Text(
              message,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .01,
            ),
            ElevatedButton(
              onPressed: () async {
                onPress();
                Navigator.pop(context);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
