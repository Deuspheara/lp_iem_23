import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Comment {
  String? comment;
  int? createdAt;

  Comment({
    this.comment,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
