// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChapterModel _$ChapterModelFromJson(Map<String, dynamic> json) =>
    _ChapterModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content_text'] as String?,
      audio: json['audio'] as String?,
    );

Map<String, dynamic> _$ChapterModelToJson(_ChapterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content_text': instance.content,
      'audio': instance.audio,
    };
