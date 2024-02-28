import 'package:cnattendance/data/source/network/model/projectlist/AssignedMember.dart';
import 'package:cnattendance/data/source/network/model/projectlist/ProjectLeader.dart';

class Data {
  List<AssignedMember> assigned_member;
  int assigned_task_count;
  String client_name;
  String cover_pic;
  String deadline;
  String description;
  int id;
  String name;
  String priority;
  List<ProjectLeader> project_leader;
  String startDate;
  String status;
  int progress_percent;

  Data({
    required this.assigned_member,
    required this.assigned_task_count,
    required this.client_name,
    required this.cover_pic,
    required this.deadline,
    required this.description,
    required this.id,
    required this.name,
    required this.priority,
    required this.project_leader,
    required this.startDate,
    required this.status,
    required this.progress_percent,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_member: (json['assigned_member'] as List).map((i) => AssignedMember.fromJson(i)).toList(),
      assigned_task_count: json['assigned_task_count'],
      client_name: json['client_name'],
      cover_pic: json['cover_pic'],
      deadline: json['deadline'],
      description: json['description'],
      id: json['id'],
      name: json['name'],
      priority: json['priority'],
      project_leader: (json['project_leader'] as List).map((i) => ProjectLeader.fromJson(i)).toList(),
      startDate: json['start_date'],
      status: json['status'],
      progress_percent: json['progress_percent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_task_count'] = assigned_task_count;
    data['client_name'] = client_name;
    data['cover_pic'] = cover_pic;
    data['deadline'] = deadline;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['priority'] = priority;
    data['start_date'] = startDate;
    data['status'] = status;
    data['progress_percent'] = progress_percent;
    data['assigned_member'] = assigned_member.map((v) => v.toJson()).toList();
    data['project_leader'] = project_leader.map((v) => v.toJson()).toList();
    return data;
  }
}
