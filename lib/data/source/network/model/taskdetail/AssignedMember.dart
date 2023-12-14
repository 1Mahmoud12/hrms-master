class AssignedMember {
    String avatar;
    int id;
    String name;
    String post;

    AssignedMember({required this.avatar,required this.id,required this.name,required this.post});

    factory AssignedMember.fromJson(Map<String, dynamic> json) {
        return AssignedMember(
            avatar: json['avatar'], 
            id: json['id'], 
            name: json['name'], 
            post: json['post'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = <String, dynamic>{};
        data['avatar'] = avatar;
        data['id'] = id;
        data['name'] = name;
        data['post'] = post;
        return data;
    }
}