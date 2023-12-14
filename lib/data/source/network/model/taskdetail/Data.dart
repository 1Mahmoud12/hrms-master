import 'package:cnattendance/data/source/network/model/taskdetail/AssignedMember.dart';
import 'package:cnattendance/data/source/network/model/taskdetail/Attachment.dart';
import 'package:cnattendance/data/source/network/model/taskdetail/Checklists.dart';
import 'package:cnattendance/data/source/network/model/taskdetail/TaskComment.dart';

class Data {
  List<AssignedMember> assigned_member;
  List<Attachment> attachments;
  List<Checklists> checklists;
  String deadline;
  String description;
  String priority;
  String project_name;
  String start_date;
  String status;
  List<TaskComment> task_comments;
  int task_id;
  String task_name;
  bool has_checklist;
  int task_progress_percent;

  Data(
      {required this.assigned_member,
      required this.attachments,
      required this.checklists,
      required this.deadline,
      required this.description,
      required this.priority,
      required this.project_name,
      required this.start_date,
      required this.status,
      required this.task_comments,
      required this.task_id,
      required this.task_name,
      required this.has_checklist,
      required this.task_progress_percent,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_member: (json['assigned_member'] as List)
          .map((i) => AssignedMember.fromJson(i))
          .toList(),
      attachments: (json['attachments'] as List)
          .map((i) => Attachment.fromJson(i))
          .toList(),
      checklists: (json['checklists'] as List)
          .map((i) => Checklists.fromJson(i))
          .toList(),
      deadline: json['deadline'],
      description: json['description'],
      priority: json['priority'],
      project_name: json['project_name'],
      start_date: json['start_date'],
      status: json['status'],
      task_comments: (json['task_comments'] as List)
          .map((i) => TaskComment.fromJson(i))
          .toList(),
      task_id: json['task_id'],
      task_name: json['task_name'],
      has_checklist: json['has_checklist'],
      task_progress_percent: json['task_progress_percent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deadline'] = deadline;
    data['description'] = description;
    data['priority'] = priority;
    data['project_name'] = project_name;
    data['start_date'] = start_date;
    data['status'] = status;
    data['task_id'] = task_id;
    data['task_name'] = task_name;
    data['task_progress_percent'] = task_progress_percent;
    data['assigned_member'] =
        assigned_member.map((v) => v.toJson()).toList();
      data['attachments'] = attachments.map((v) => v.toJson()).toList();
      data['checklists'] = checklists.map((v) => v.toJson()).toList();
      data['task_comments'] =
        task_comments.map((v) => v.toJson()).toList();
      return data;
  }
}
