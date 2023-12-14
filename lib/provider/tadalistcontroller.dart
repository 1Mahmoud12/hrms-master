import 'package:cnattendance/model/tadaother.dart';
import 'package:cnattendance/repositories/tadarepository.dart';
import 'package:cnattendance/screen/tadascreen/createtadascreen.dart';
import 'package:cnattendance/screen/tadascreen/edittadascreen.dart';
import 'package:cnattendance/screen/tadascreen/tadadetailscreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TadaListController extends GetxController {
  final filteredList = <Tadaother>[].obs;
  final tadaList = <Tadaother>[].obs;
  final tadaList_pending = <Tadaother>[].obs;
  final tadaList_rejected = <Tadaother>[].obs;
  final tadaList_accepted = <Tadaother>[].obs;
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
          listPending.add(Tadaother.list(
            tada.id,
            tada.title,
            tada.total_expense,
            tada.status,
            tada.remark,
            tada.submitted_date,
          ),);

          tadaList_pending.value = listPending;
        } else if (tada.status == 'Rejected') {
          listRejected.add(Tadaother.list(
            tada.id,
            tada.title,
            tada.total_expense,
            tada.status,
            tada.remark,
            tada.submitted_date,
          ),);

          tadaList_rejected.value = listRejected;
        } else if (tada.status == 'Accepted') {
          listAccepted.add(Tadaother.list(
            tada.id,
            tada.title,
            tada.total_expense,
            tada.status,
            tada.remark,
            tada.submitted_date,
          ),);

          tadaList_accepted.value = listAccepted;
        }
        list.add(Tadaother.list(
          tada.id,
          tada.title,
          tada.total_expense,
          tada.status,
          tada.remark,
          tada.submitted_date,
        ),);
      }
      tadaList.value = list;
      filteredList.addAll(tadaList);
      print('-------------------tadaList_accepted');
      print(tadaList_accepted);
      print('--------------------tadaList_pending');
      print(tadaList_pending);
      print('--------------------tadaList_rejected');
      print(tadaList_rejected);

      return 'Loaded';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  filterList() {
    filteredList.clear();
    if (selected.value == 'Rejected') {
      filteredList.addAll(tadaList_rejected);
    } else if (selected.value == 'Accepted') {
      filteredList.addAll(tadaList_accepted);
    } else if (selected.value == 'Pending') {
      filteredList.addAll(tadaList_pending);
    } else {
      filteredList.addAll(tadaList);
    }
    update();
    print(filteredList);
    print(selected.value);
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
