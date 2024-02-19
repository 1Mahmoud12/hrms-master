class AddReportSalesParams {
  final int formRequestId;
  final String reportSales;

  AddReportSalesParams({required this.formRequestId, required this.reportSales});

  Map<String, dynamic> toJson() => {
        'form_request_id': formRequestId.toString(),
        'report_technical': reportSales,
      };
}
