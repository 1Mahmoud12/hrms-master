class Checklists {
  int id;
  String is_completed;
  String name;
  String task_id;

  Checklists(
      {required this.id,
      required this.is_completed,
      required this.name,
      required this.task_id,});

  factory Checklists.fromJson(Map<String, dynamic> json) {
    return Checklists(
      id: json['id'],
      is_completed: json['is_completed'],
      name: json['name'],
      task_id: json['task_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_completed'] = is_completed;
    data['name'] = name;
    data['task_id'] = task_id;
    return data;
  }
}
