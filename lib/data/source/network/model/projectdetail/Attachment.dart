class Attachment {
  String attachment_url;
  String extension;
  String type;
  int id;

  Attachment({
    required this.attachment_url,
    required this.extension,
    required this.type,
    required this.id,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      attachment_url: json['attachment_url'],
      extension: json['extension'],
      type: json['type'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attachment_url'] = attachment_url;
    data['extension'] = extension;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
