import 'package:cnattendance/data/source/network/model/projectdashboard/AssignedMemberX.dart';

class Project {
  List<AssignedMemberX> assigned_member;
  int assigned_task_count;
  String end_date;
  int id;
  String priority;
  String project_name;
  int project_progress_percent;
  String startDate;
  String status;

  Project({
    required this.assigned_member,
    required this.assigned_task_count,
    required this.end_date,
    required this.id,
    required this.priority,
    required this.project_name,
    required this.project_progress_percent,
    required this.startDate,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      assigned_member: (json['assigned_member'] as List).map((i) => AssignedMemberX.fromJson(i)).toList(),
      assigned_task_count: json['assigned_task_count'],
      end_date: json['end_date'],
      id: json['id'],
      priority: json['priority'],
      project_name: json['project_name'],
      project_progress_percent: json['project_progress_percent'],
      startDate: json['start_date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_task_count'] = assigned_task_count;
    data['end_date'] = end_date;
    data['id'] = id;
    data['priority'] = priority;
    data['project_name'] = project_name;
    data['project_progress_percent'] = project_progress_percent;
    data['start_date'] = startDate;
    data['status'] = status;
    data['assigned_member'] = assigned_member.map((v) => v.toJson()).toList();
    return data;
  }
}
