class ProjectLeader {
    String avatar;
    int id;
    String name;

    ProjectLeader({required this.avatar,required this.id,required this.name});

    factory ProjectLeader.fromJson(Map<String, dynamic> json) {
        return ProjectLeader(
            avatar: json['avatar'], 
            id: json['id'], 
            name: json['name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['avatar'] = avatar;
        data['id'] = id;
        data['name'] = name;
        return data;
    }
}