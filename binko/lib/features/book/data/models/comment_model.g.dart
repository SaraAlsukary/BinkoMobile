// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: (json['id'] as num?)?.toInt(),
      comment: json['comment'] as String?,
      userName: json['user_name'] as String?,
      userImage: json['user_image'] as String?,
      replyCount: (json['reply_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'user_name': instance.userName,
      'user_image': instance.userImage,
      'reply_count': instance.replyCount,
    };
