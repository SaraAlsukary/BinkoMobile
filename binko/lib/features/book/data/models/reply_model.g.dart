// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => _ReplyModel(
      id: (json['id'] as num?)?.toInt(),
      content: json['content'] as String?,
      userId: (json['user'] as num?)?.toInt(),
      userName: json['name'] as String?,
      userImage: json['image'] as String?,
      createdAt: json['created_at'] as String?,
      commentId: (json['comment'] as num?)?.toInt(),
      parentId: (json['parent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReplyModelToJson(_ReplyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'user': instance.userId,
      'name': instance.userName,
      'image': instance.userImage,
      'created_at': instance.createdAt,
      'comment': instance.commentId,
      'parent': instance.parentId,
    };
