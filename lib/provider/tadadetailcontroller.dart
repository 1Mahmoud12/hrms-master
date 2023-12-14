import 'package:cnattendance/model/attachment.dart';
import 'package:cnattendance/model/tada.dart';
import 'package:cnattendance/repositories/tadarepository.dart';
import 'package:cnattendance/screen/tadascreen/edittadascreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class TadaDetailController extends GetxController {
  Rx<Tada> tada = Tada(0, '', '', '', '', '', '', '', []).obs;
  RxBool isLoading = false.obs;
  TadaRepository repository = TadaRepository();

  Future<String> getTadaDetail() async {
    try {
      isLoading.value = true;
      EasyLoading.show(
          status: 'Loading, Please Wait...',
          maskType: EasyLoadingMaskType.black,);
      final response =
          await repository.getTadaDetail(Get.arguments['tadaId'].toString());
      EasyLoading.dismiss();

      final data = response.data;
      final attachmentList = <Attachment>[];
      for (final attachment in data.attachments.image) {
        attachmentList.add(Attachment(attachment.id, attachment.url, 'image'));
      }
      for (final attachment in data.attachments.file) {
        attachmentList.add(Attachment(attachment.id, attachment.url, 'file'));
      }

      final Tada rTada = Tada(
          data.id,
          data.title,
          data.description,
          data.total_expense.toString(),
          data.status,
          data.remark,
          data.verified_by,
          data.submitted_date,
          attachmentList,);

      tada.value = rTada;

      isLoading.value = false;
      return 'Loaded';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void onTadaEditClicked(String id) {
    Get.to(const EditTadaScreen(),
        transition: Transition.cupertino, arguments: {'tadaId': id},);
  }

  @override
  void onInit() {
    getTadaDetail();
    super.onInit();
  }
}
