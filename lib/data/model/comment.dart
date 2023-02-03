import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Comment {
  String? text;
  String? createdAt;

  Comment({
    this.text,
    this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
