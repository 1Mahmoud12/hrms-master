class DataX {
  String description;
  String query_date;
  String requested_department;
  String status;
  String title;
  String updated_by;
  String updated_at;

  DataX(
      {required this.description,
      required this.query_date,
      required this.requested_department,
      required this.status,
      required this.title,
      required this.updated_by,
      required this.updated_at,});

  factory DataX.fromJson(Map<String, dynamic> json) {
    return DataX(
      description: json['description'],
      query_date: json['query_date'],
      requested_department: json['requested_department'],
      status: json['status'],
      title: json['title'],
      updated_by: json['updated_by'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['query_date'] = query_date;
    data['requested_department'] = requested_department;
    data['status'] = status;
    data['title'] = title;
    return data;
  }
}
