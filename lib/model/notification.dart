class Notification {
  int id;
  String title;
  String description;
  String month;
  int day;
  DateTime date;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.month,
    required this.day,
    required this.date,
  });

  List<Object> toJson() => [id, title, description, month, day, date];
}
