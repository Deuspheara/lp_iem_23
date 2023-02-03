import 'package:json_annotation/json_annotation.dart';
import 'package:spots_discovery/data/model/comment.dart';

part 'comments.g.dart';

@JsonSerializable(
    checked: true, explicitToJson: true, fieldRename: FieldRename.snake)
class Comments {
  final Map<String, Comment>? comments;

  Comments({
    this.comments,
  });

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
