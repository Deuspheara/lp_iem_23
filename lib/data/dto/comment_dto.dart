import 'package:json_annotation/json_annotation.dart';

part 'comment_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentDto {
  final String name;

  CommentDto({
    required this.name,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) =>
      _$CommentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDtoToJson(this);
}
