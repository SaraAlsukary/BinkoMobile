// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BooksModel _$BooksModelFromJson(Map<String, dynamic> json) => _BooksModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      author: json['user'] == null
          ? null
          : AuthorModel.fromJson(json['user'] as Map<String, dynamic>),
      description: json['description'] as String?,
      pubDat: json['publication_date'] == null
          ? null
          : DateTime.parse(json['publication_date'] as String),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isAccept: json['is_accept'] as bool?,
    );

Map<String, dynamic> _$BooksModelToJson(_BooksModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'user': instance.author,
      'description': instance.description,
      'publication_date': instance.pubDat?.toIso8601String(),
      'categories': instance.categories,
      'is_accept': instance.isAccept,
    };

_AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => _AuthorModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AuthorModelToJson(_AuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
