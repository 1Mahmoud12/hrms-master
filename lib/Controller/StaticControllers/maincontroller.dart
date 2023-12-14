import 'package:get/get.dart';

class MaindartController extends GetxController {
  // MainController.box;
  RxBool directionrlt = false.obs;

  int radiovaluelanguage = 0;
  updatelanguageradio(value) {
    radiovaluelanguage = value;
    update();
  }
}
