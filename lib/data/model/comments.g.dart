// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Comments',
      json,
      ($checkedConvert) {
        final val = Comments(
          comments: $checkedConvert(
              'comments',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(
                        k, Comment.fromJson(e as Map<String, dynamic>)),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'comments': instance.comments?.map((k, e) => MapEntry(k, e.toJson())),
    };
