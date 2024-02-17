class AddReportSalesParams {
  final int formRequestId;
  final String reportTechnical;

  AddReportSalesParams({required this.formRequestId, required this.reportTechnical});

  Map<String, dynamic> toJson() => {
        'form_request_id': formRequestId.toString(),
        'report_technical': reportTechnical,
      };
}
