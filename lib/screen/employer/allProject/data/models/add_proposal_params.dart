class AddReportParams {
  final int formRequestId;
  final String cost;
  final String reportTechnical;

  AddReportParams({required this.cost, required this.formRequestId, required this.reportTechnical});

  Map<String, dynamic> toJson() => {
        'form_request_id': formRequestId.toString(),
        'report_engineer': reportTechnical,
        'costs': cost,
      };
}
