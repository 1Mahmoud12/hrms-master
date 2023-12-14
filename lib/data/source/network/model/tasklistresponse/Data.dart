
class Data {
  int assigned_checklists_count;
  String deadline;
  String priority;
  String project_name;
  String start_date;
  String end_date;
  String status;
  int task_id;
  String task_name;
  int task_progress_percent;

  Data(
      {required this.assigned_checklists_count,
      required this.deadline,
      required this.priority,
      required this.project_name,
      required this.start_date,
      required this.end_date,
      required this.status,
      required this.task_id,
      required this.task_name,
      required this.task_progress_percent,});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      assigned_checklists_count: json['assigned_checklists_count'],
      deadline: json['deadline'],
      priority: json['priority'],
      project_name: json['project_name'],
      start_date: json['start_date'],
      end_date: json['deadline']??'',
      status: json['status'],
      task_id: json['task_id'],
      task_name: json['task_name'],
      task_progress_percent: json['task_progress_percent'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_checklists_count'] = assigned_checklists_count;
    data['deadline'] = deadline;
    data['priority'] = priority;
    data['project_name'] = project_name;
    data['start_date'] = start_date;
    data['status'] = status;
    data['task_id'] = task_id;
    data['task_name'] = task_name;
    data['task_progress_percent'] = task_progress_percent;
    return data;
  }
}
