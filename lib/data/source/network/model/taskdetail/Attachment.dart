class Attachment {
    String attachment_url;
    String extension;
    String type;

    Attachment({required this.attachment_url,required this.extension,required this.type});

    factory Attachment.fromJson(Map<String, dynamic> json) {
        return Attachment(
            attachment_url: json['attachment_url'], 
            extension: json['extension'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['attachment_url'] = attachment_url;
        data['extension'] = extension;
        data['type'] = type;
        return data;
    }
}