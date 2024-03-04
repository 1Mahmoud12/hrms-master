class ChangeDateParams {
  final String projectId;
  final String deadline;

  ChangeDateParams({required this.projectId, required this.deadline});
  Map<String, String> toJson() => {
        'projectid': projectId,
        'deadline': deadline,
      };
}
