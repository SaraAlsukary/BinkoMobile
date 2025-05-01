// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    _CategoriesModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      nameArabic: json['name_arabic'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$CategoriesModelToJson(_CategoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_arabic': instance.nameArabic,
      'file': instance.file,
    };
