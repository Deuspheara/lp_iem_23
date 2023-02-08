// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Comment',
      json,
      ($checkedConvert) {
        final val = Comment(
          comment: $checkedConvert('comment', (v) => v as String?),
          createdAt: $checkedConvert('created_at', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment': instance.comment,
      'created_at': instance.createdAt,
    };
