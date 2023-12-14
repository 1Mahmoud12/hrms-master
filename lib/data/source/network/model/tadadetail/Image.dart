class Image {
    int id;
    String url;

    Image({required this.id,required this.url});

    factory Image.fromJson(Map<String, dynamic> json) {
        return Image(
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