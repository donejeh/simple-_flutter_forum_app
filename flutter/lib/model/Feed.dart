class Feed {
  Feed({
      this.id, 
      this.userId, 
      this.content, 
      this.createdAt, 
      this.updatedAt, 
      this.liked,});

  Feed.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    liked = json['liked'];
  }
  int? id;
  int? userId;
  String? content;
  String? createdAt;
  String? updatedAt;
  bool? liked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['content'] = content;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['liked'] = liked;
    return map;
  }

}