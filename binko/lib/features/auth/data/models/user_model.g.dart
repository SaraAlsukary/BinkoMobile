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
    };
