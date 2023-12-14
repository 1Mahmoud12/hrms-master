class File {
    int id;
    String url;

    File({required this.id,required this.url});

    factory File.fromJson(Map<String, dynamic> json) {
        return File(
            id: json['id'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['id'] = id;
        data['url'] = url;
        return data;
    }
}