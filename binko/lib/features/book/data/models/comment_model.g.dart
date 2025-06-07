// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CommentModel _$CommentModelFromJson(Map<String, dynamic> json) =>
    _CommentModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      book: json['book'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CommentModelToJson(_CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'book': instance.book,
      'comment': instance.comment,
    };
