// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReplyModel {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'content')
  String? get content;
  @JsonKey(name: 'user')
  int? get userId;
  @JsonKey(name: 'name')
  String? get userName;
  @JsonKey(name: 'image')
  String? get userImage;
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @JsonKey(name: 'comment')
  int? get commentId;
  @JsonKey(name: 'parent')
  int? get parentId;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReplyModelCopyWith<ReplyModel> get copyWith =>
      _$ReplyModelCopyWithImpl<ReplyModel>(this as ReplyModel, _$identity);

  /// Serializes this ReplyModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReplyModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, userId, userName,
      userImage, createdAt, commentId, parentId);

  @override
  String toString() {
    return 'ReplyModel(id: $id, content: $content, userId: $userId, userName: $userName, userImage: $userImage, createdAt: $createdAt, commentId: $commentId, parentId: $parentId)';
  }
}

/// @nodoc
abstract mixin class $ReplyModelCopyWith<$Res> {
  factory $ReplyModelCopyWith(
          ReplyModel value, $Res Function(ReplyModel) _then) =
      _$ReplyModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'user') int? userId,
      @JsonKey(name: 'name') String? userName,
      @JsonKey(name: 'image') String? userImage,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'comment') int? commentId,
      @JsonKey(name: 'parent') int? parentId});
}

/// @nodoc
class _$ReplyModelCopyWithImpl<$Res> implements $ReplyModelCopyWith<$Res> {
  _$ReplyModelCopyWithImpl(this._self, this._then);

  final ReplyModel _self;
  final $Res Function(ReplyModel) _then;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userImage = freezed,
    Object? createdAt = freezed,
    Object? commentId = freezed,
    Object? parentId = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _self.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ReplyModel implements ReplyModel {
  const _ReplyModel(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'user') this.userId,
      @JsonKey(name: 'name') this.userName,
      @JsonKey(name: 'image') this.userImage,
      @JsonKey(name: 'created_at') this.createdAt,
      @JsonKey(name: 'comment') this.commentId,
      @JsonKey(name: 'parent') this.parentId});
  factory _ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'user')
  final int? userId;
  @override
  @JsonKey(name: 'name')
  final String? userName;
  @override
  @JsonKey(name: 'image')
  final String? userImage;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'comment')
  final int? commentId;
  @override
  @JsonKey(name: 'parent')
  final int? parentId;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyModelCopyWith<_ReplyModel> get copyWith =>
      __$ReplyModelCopyWithImpl<_ReplyModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReplyModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, content, userId, userName,
      userImage, createdAt, commentId, parentId);

  @override
  String toString() {
    return 'ReplyModel(id: $id, content: $content, userId: $userId, userName: $userName, userImage: $userImage, createdAt: $createdAt, commentId: $commentId, parentId: $parentId)';
  }
}

/// @nodoc
abstract mixin class _$ReplyModelCopyWith<$Res>
    implements $ReplyModelCopyWith<$Res> {
  factory _$ReplyModelCopyWith(
          _ReplyModel value, $Res Function(_ReplyModel) _then) =
      __$ReplyModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'user') int? userId,
      @JsonKey(name: 'name') String? userName,
      @JsonKey(name: 'image') String? userImage,
      @JsonKey(name: 'created_at') String? createdAt,
      @JsonKey(name: 'comment') int? commentId,
      @JsonKey(name: 'parent') int? parentId});
}

/// @nodoc
class __$ReplyModelCopyWithImpl<$Res> implements _$ReplyModelCopyWith<$Res> {
  __$ReplyModelCopyWithImpl(this._self, this._then);

  final _ReplyModel _self;
  final $Res Function(_ReplyModel) _then;

  /// Create a copy of ReplyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? userId = freezed,
    Object? userName = freezed,
    Object? userImage = freezed,
    Object? createdAt = freezed,
    Object? commentId = freezed,
    Object? parentId = freezed,
  }) {
    return _then(_ReplyModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _self.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
