class AddReportEngineerParams {
  final int formRequestId;
  final String cost;
  final String reportTechnical;
  final String? reportSales;

  AddReportEngineerParams({required this.cost, required this.formRequestId, required this.reportTechnical, this.reportSales});

  Map<String, dynamic> toJson() => {
        'form_request_id': formRequestId.toString(),
        'report_engineer': reportTechnical,
        'report_technical': reportSales,
        'costs': cost,
      };
}
