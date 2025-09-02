// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      username: json['username'] as String?,
      isAdmin: json['is_admin'] as bool?,
      isSupervisor: json['is_supervisor'] as bool?,
      image: json['image'] as String?,
      discriptions: json['discriptions'] as String?,
      category: json['category'],
      age: (json['age'] as num?)?.toInt(),
      isReader: json['is_reader'] as bool?,
      isAccept: json['is_accept'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'is_admin': instance.isAdmin,
      'is_supervisor': instance.isSupervisor,
      'image': instance.image,
      'discriptions': instance.discriptions,
      'category': instance.category,
      'age': instance.age,
      'is_reader': instance.isReader,
      'is_accept': instance.isAccept,
    };
