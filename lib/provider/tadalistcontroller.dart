import 'package:cnattendance/model/tadaother.dart';
import 'package:cnattendance/repositories/tadarepository.dart';
import 'package:cnattendance/screen/tadascreen/createtadascreen.dart';
import 'package:cnattendance/screen/tadascreen/edittadascreen.dart';
import 'package:cnattendance/screen/tadascreen/tadadetailscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TadaListController extends GetxController {
  final filteredList = <Tadaother>[].obs;
  final tadaList = <Tadaother>[].obs;
  final tadaListPending = <Tadaother>[].obs;
  final tadaListRejected = <Tadaother>[].obs;
  final tadaListAccepted = <Tadaother>[].obs;
  final selected = 'All'.obs;
  final indexSelected = 0.obs;
  final tadaListLabels = ['All'.tr, 'Pending'.tr, 'Accepted'.tr, 'Rejected'.tr];
  TadaRepository repository = TadaRepository();

  Future<String> getTadaList() async {
    try {
      EasyLoading.show(status: 'Loading, Please Wait...', maskType: EasyLoadingMaskType.black);
      final response = await repository.getTadaList();
      EasyLoading.dismiss();

      final list = <Tadaother>[];
      final listPending = <Tadaother>[];
      final listRejected = <Tadaother>[];
      final listAccepted = <Tadaother>[];

      for (final tada in response.data) {
        if (tada.status == 'Pending') {
          listPending.add(
            Tadaother.list(
              tada.id,
              tada.title,
              tada.total_expense,
              tada.status,
              tada.remark,
              tada.submitted_date,
            ),
          );

          tadaListPending.value = listPending;
        } else if (tada.status == 'Rejected') {
          listRejected.add(
            Tadaother.list(
              tada.id,
              tada.title,
              tada.total_expense,
              tada.status,
              tada.remark,
              tada.submitted_date,
            ),
          );

          tadaListRejected.value = listRejected;
        } else if (tada.status == 'Accepted') {
          listAccepted.add(
            Tadaother.list(
              tada.id,
              tada.title,
              tada.total_expense,
              tada.status,
              tada.remark,
              tada.submitted_date,
            ),
          );

          tadaListAccepted.value = listAccepted;
        }
        list.add(
          Tadaother.list(
            tada.id,
            tada.title,
            tada.total_expense,
            tada.status,
            tada.remark,
            tada.submitted_date,
          ),
        );
      }
      tadaList.value = list;
      filteredList.addAll(tadaList);
      debugPrint('-------------------tadaList_accepted');
      debugPrint('$tadaListAccepted');
      debugPrint('--------------------tadaList_pending');
      debugPrint('$tadaListPending');
      debugPrint('--------------------tadaList_rejected');
      debugPrint('$tadaListRejected');

      return 'Loaded';
    } catch (e) {
      debugPrint('$e');
      rethrow;
    }
  }

  void filterList() {
    filteredList.clear();
    if (selected.value == 'Rejected') {
      filteredList.addAll(tadaListRejected);
    } else if (selected.value == 'Accepted') {
      filteredList.addAll(tadaListAccepted);
    } else if (selected.value == 'Pending') {
      filteredList.addAll(tadaListPending);
    } else {
      filteredList.addAll(tadaList);
    }
    update();
    debugPrint('$filteredList');
    debugPrint(selected.value);
  }

  void onTadaClicked(String id) {
    Get.to(const TadaDetailScreen(), transition: Transition.cupertino, arguments: {'tadaId': id});
  }

  void onTadaEditClicked(String id) {
    Get.to(const EditTadaScreen(), transition: Transition.cupertino, arguments: {'tadaId': id});
  }

  void onTadaCreateClicked() {
    Get.to(const CreateTadaScreen(), transition: Transition.cupertino);
  }

  @override
  void onInit() {
    getTadaList();
    super.onInit();
  }
}
