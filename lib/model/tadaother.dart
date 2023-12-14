import 'attachment.dart';

class Tadaother {
  int id;
  String title;
  String? description;
  int expenses;
  String status;
  String remark;
  String? verifiedBy;
  String submittedDate;
  List<Attachment>? attachments;

  Tadaother(this.id, this.title, this.description, this.expenses, this.status,
      this.remark, this.verifiedBy, this.submittedDate, this.attachments,);

  Tadaother.list(this.id, this.title, this.expenses, this.status, this.remark,
      this.submittedDate,);
}
