class ChangeStatusParams {
  final String projectId;
  final String status;

  ChangeStatusParams({required this.projectId, required this.status});

  Map<String, String> toJson() => {
        'projectid': projectId,
        'status': status,
      };
}
