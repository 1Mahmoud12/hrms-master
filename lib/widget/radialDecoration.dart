import 'package:flutter/cupertino.dart';

BoxDecoration HomeRadialDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/background_home.png'),
        fit: BoxFit.fitWidth,
        // opacity: .7,
        alignment: Alignment.topCenter,),
    // gradient: RadialGradient(colors: [
    //   HexColor("#011754"),
    //   HexColor("#041033"),
    // ]
  );
}

BoxDecoration RadialDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/background_screen2.png'),
        fit: BoxFit.fitWidth,
        // opacity: .7,
        alignment: Alignment.topCenter,),
    // gradient: RadialGradient(colors: [
    //   HexColor("#011754"),
    //   HexColor("#041033"),
    // ]
  );
}
