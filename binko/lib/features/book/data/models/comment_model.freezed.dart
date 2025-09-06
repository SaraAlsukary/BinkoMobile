// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentModel {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'comment')
  String? get comment;
  @JsonKey(name: 'user_name')
  String? get userName;
  @JsonKey(name: 'user_image')
  String? get userImage;
  @JsonKey(name: 'reply_count')
  int? get replyCount;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentModelCopyWith<CommentModel> get copyWith =>
      _$CommentModelCopyWithImpl<CommentModel>(
          this as CommentModel, _$identity);

  /// Serializes this CommentModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, comment, userName, userImage, replyCount);

  @override
  String toString() {
    return 'CommentModel(id: $id, comment: $comment, userName: $userName, userImage: $userImage, replyCount: $replyCount)';
  }
}

/// @nodoc
abstract mixin class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) _then) =
      _$CommentModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'comment') String? comment,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_image') String? userImage,
      @JsonKey(name: 'reply_count') int? replyCount});
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res> implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._self, this._then);

  final CommentModel _self;
  final $Res Function(CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? comment = freezed,
    Object? userName = freezed,
    Object? userImage = freezed,
    Object? replyCount = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _self.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      replyCount: freezed == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CommentModel implements CommentModel {
  const _CommentModel(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'comment') this.comment,
      @JsonKey(name: 'user_name') this.userName,
      @JsonKey(name: 'user_image') this.userImage,
      @JsonKey(name: 'reply_count') this.replyCount});
  factory _CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'comment')
  final String? comment;
  @override
  @JsonKey(name: 'user_name')
  final String? userName;
  @override
  @JsonKey(name: 'user_image')
  final String? userImage;
  @override
  @JsonKey(name: 'reply_count')
  final int? replyCount;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentModelCopyWith<_CommentModel> get copyWith =>
      __$CommentModelCopyWithImpl<_CommentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CommentModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, comment, userName, userImage, replyCount);

  @override
  String toString() {
    return 'CommentModel(id: $id, comment: $comment, userName: $userName, userImage: $userImage, replyCount: $replyCount)';
  }
}

/// @nodoc
abstract mixin class _$CommentModelCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$CommentModelCopyWith(
          _CommentModel value, $Res Function(_CommentModel) _then) =
      __$CommentModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'comment') String? comment,
      @JsonKey(name: 'user_name') String? userName,
      @JsonKey(name: 'user_image') String? userImage,
      @JsonKey(name: 'reply_count') int? replyCount});
}

/// @nodoc
class __$CommentModelCopyWithImpl<$Res>
    implements _$CommentModelCopyWith<$Res> {
  __$CommentModelCopyWithImpl(this._self, this._then);

  final _CommentModel _self;
  final $Res Function(_CommentModel) _then;

  /// Create a copy of CommentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? comment = freezed,
    Object? userName = freezed,
    Object? userImage = freezed,
    Object? replyCount = freezed,
  }) {
    return _then(_CommentModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _self.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      replyCount: freezed == replyCount
          ? _self.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
