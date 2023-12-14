import 'Participator.dart';

class MeetingDomain {
  MeetingDomain({
    required this.id,
    required this.title,
    required this.agenda,
    required this.venue,
    required this.meetingDate,
    required this.meetingStartTime,
    required this.publishDate,
    required this.image,
    required this.createdBy,
    required this.participator,
  });

  factory MeetingDomain.fromJson(dynamic json) {
    return MeetingDomain(
      id: json['id'],
      title: json['title'] ?? '',
      agenda: json['agenda'] ?? '',
      venue: json['venue'] ?? '',
      meetingDate: json['meeting_date'] ?? '',
      meetingStartTime: json['meeting_start_time'] ?? '',
      publishDate: json['publish_date'] ?? '',
      image: json['image'] ?? '',
      createdBy: json['created_by'] ?? '',
      participator: List<Participator>.from(
        json['participator'].map((x) => Participator.fromJson(x)),
      ),
    );
  }

  int id;
  String title;
  String agenda;
  String venue;
  String meetingDate;
  String meetingStartTime;
  String publishDate;
  String image;
  String createdBy;
  List<Participator> participator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['agenda'] = agenda;
    map['venue'] = venue;
    map['meeting_date'] = meetingDate;
    map['meeting_start_time'] = meetingStartTime;
    map['publish_date'] = publishDate;
    map['image'] = image;
    map['created_by'] = createdBy;
    map['participator'] = participator.map((v) => v.toJson()).toList();
    return map;
  }
}
