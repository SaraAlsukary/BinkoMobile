// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "username")
  String? get username;
  @JsonKey(name: "is_admin")
  bool? get isAdmin;
  @JsonKey(name: "is_supervisor")
  bool? get isSupervisor;
  @JsonKey(name: "image")
  String? get image;
  @JsonKey(name: "discriptions")
  String? get discriptions;
  @JsonKey(name: "category")
  dynamic get category;
  @JsonKey(name: "age")
  int? get age;
  @JsonKey(name: "is_reader")
  bool? get isReader;
  @JsonKey(name: "is_accept")
  bool? get isAccept;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isSupervisor, isSupervisor) ||
                other.isSupervisor == isSupervisor) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.discriptions, discriptions) ||
                other.discriptions == discriptions) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.isReader, isReader) ||
                other.isReader == isReader) &&
            (identical(other.isAccept, isAccept) ||
                other.isAccept == isAccept));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      username,
      isAdmin,
      isSupervisor,
      image,
      discriptions,
      const DeepCollectionEquality().hash(category),
      age,
      isReader,
      isAccept);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, username: $username, isAdmin: $isAdmin, isSupervisor: $isSupervisor, image: $image, discriptions: $discriptions, category: $category, age: $age, isReader: $isReader, isAccept: $isAccept)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "username") String? username,
      @JsonKey(name: "is_admin") bool? isAdmin,
      @JsonKey(name: "is_supervisor") bool? isSupervisor,
      @JsonKey(name: "image") String? image,
      @JsonKey(name: "discriptions") String? discriptions,
      @JsonKey(name: "category") dynamic category,
      @JsonKey(name: "age") int? age,
      @JsonKey(name: "is_reader") bool? isReader,
      @JsonKey(name: "is_accept") bool? isAccept});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? isAdmin = freezed,
    Object? isSupervisor = freezed,
    Object? image = freezed,
    Object? discriptions = freezed,
    Object? category = freezed,
    Object? age = freezed,
    Object? isReader = freezed,
    Object? isAccept = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: freezed == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSupervisor: freezed == isSupervisor
          ? _self.isSupervisor
          : isSupervisor // ignore: cast_nullable_to_non_nullable
              as bool?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      discriptions: freezed == discriptions
          ? _self.discriptions
          : discriptions // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as dynamic,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      isReader: freezed == isReader
          ? _self.isReader
          : isReader // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAccept: freezed == isAccept
          ? _self.isAccept
          : isAccept // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UserModel implements UserModel {
  const _UserModel(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "username") this.username,
      @JsonKey(name: "is_admin") this.isAdmin,
      @JsonKey(name: "is_supervisor") this.isSupervisor,
      @JsonKey(name: "image") this.image,
      @JsonKey(name: "discriptions") this.discriptions,
      @JsonKey(name: "category") this.category,
      @JsonKey(name: "age") this.age,
      @JsonKey(name: "is_reader") this.isReader,
      @JsonKey(name: "is_accept") this.isAccept});
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "username")
  final String? username;
  @override
  @JsonKey(name: "is_admin")
  final bool? isAdmin;
  @override
  @JsonKey(name: "is_supervisor")
  final bool? isSupervisor;
  @override
  @JsonKey(name: "image")
  final String? image;
  @override
  @JsonKey(name: "discriptions")
  final String? discriptions;
  @override
  @JsonKey(name: "category")
  final dynamic category;
  @override
  @JsonKey(name: "age")
  final int? age;
  @override
  @JsonKey(name: "is_reader")
  final bool? isReader;
  @override
  @JsonKey(name: "is_accept")
  final bool? isAccept;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isSupervisor, isSupervisor) ||
                other.isSupervisor == isSupervisor) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.discriptions, discriptions) ||
                other.discriptions == discriptions) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.isReader, isReader) ||
                other.isReader == isReader) &&
            (identical(other.isAccept, isAccept) ||
                other.isAccept == isAccept));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      username,
      isAdmin,
      isSupervisor,
      image,
      discriptions,
      const DeepCollectionEquality().hash(category),
      age,
      isReader,
      isAccept);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, username: $username, isAdmin: $isAdmin, isSupervisor: $isSupervisor, image: $image, discriptions: $discriptions, category: $category, age: $age, isReader: $isReader, isAccept: $isAccept)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "username") String? username,
      @JsonKey(name: "is_admin") bool? isAdmin,
      @JsonKey(name: "is_supervisor") bool? isSupervisor,
      @JsonKey(name: "image") String? image,
      @JsonKey(name: "discriptions") String? discriptions,
      @JsonKey(name: "category") dynamic category,
      @JsonKey(name: "age") int? age,
      @JsonKey(name: "is_reader") bool? isReader,
      @JsonKey(name: "is_accept") bool? isAccept});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? username = freezed,
    Object? isAdmin = freezed,
    Object? isSupervisor = freezed,
    Object? image = freezed,
    Object? discriptions = freezed,
    Object? category = freezed,
    Object? age = freezed,
    Object? isReader = freezed,
    Object? isAccept = freezed,
  }) {
    return _then(_UserModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _self.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      isAdmin: freezed == isAdmin
          ? _self.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool?,
      isSupervisor: freezed == isSupervisor
          ? _self.isSupervisor
          : isSupervisor // ignore: cast_nullable_to_non_nullable
              as bool?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      discriptions: freezed == discriptions
          ? _self.discriptions
          : discriptions // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as dynamic,
      age: freezed == age
          ? _self.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      isReader: freezed == isReader
          ? _self.isReader
          : isReader // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAccept: freezed == isAccept
          ? _self.isAccept
          : isAccept // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
