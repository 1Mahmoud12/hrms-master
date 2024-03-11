class AddTaskParams {
  final String nameTask;
  final String projectId;
  final String descriptionTask;
  final String startDateTask;
  final String endDateTask;
  final String assignedMemberTask;

  AddTaskParams({
    required this.nameTask,
    required this.descriptionTask,
    required this.startDateTask,
    required this.endDateTask,
    required this.assignedMemberTask,
    required this.projectId,
  });
  Map<String, String> toJson() => {
        'name': nameTask,
        'project_id': projectId,
        'description': descriptionTask,
        'end_date': endDateTask,
        'start_date': startDateTask,
        'assigned_member[]': assignedMemberTask,
      };
}
