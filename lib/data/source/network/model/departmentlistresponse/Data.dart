class Data {
  String dept_name;
  int id;

  Data({required this.dept_name, required this.id});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      dept_name: json['dept_name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dept_name'] = dept_name;
    data['id'] = id;
    return data;
  }
}
