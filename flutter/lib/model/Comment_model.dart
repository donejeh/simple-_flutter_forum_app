import 'Feed.dart';
import 'User.dart';

class CommentModel {
  CommentModel({
      this.id, 
      this.userId, 
      this.feedId, 
      this.body, 
      this.createdAt, 
      this.updatedAt, 
      this.feed, 
      this.user,});

  CommentModel.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    feedId = json['feed_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feed = json['feed'] != null ? Feed.fromJson(json['feed']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  int? userId;
  int? feedId;
  String? body;
  String? createdAt;
  String? updatedAt;
  Feed? feed;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['feed_id'] = feedId;
    map['body'] = body;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (feed != null) {
      map['feed'] = feed!.toJson();
    }
    if (user != null) {
      map['user'] = user!.toJson();
    }
    return map;
  }

}