// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'categories_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoriesModel {
  @JsonKey(name: "id")
  int? get id;
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "name_arabic")
  String? get nameArabic;
  @JsonKey(name: "file")
  String? get file;

  /// Create a copy of CategoriesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CategoriesModelCopyWith<CategoriesModel> get copyWith =>
      _$CategoriesModelCopyWithImpl<CategoriesModel>(
          this as CategoriesModel, _$identity);

  /// Serializes this CategoriesModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CategoriesModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameArabic, file);

  @override
  String toString() {
    return 'CategoriesModel(id: $id, name: $name, nameArabic: $nameArabic, file: $file)';
  }
}

/// @nodoc
abstract mixin class $CategoriesModelCopyWith<$Res> {
  factory $CategoriesModelCopyWith(
          CategoriesModel value, $Res Function(CategoriesModel) _then) =
      _$CategoriesModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "name_arabic") String? nameArabic,
      @JsonKey(name: "file") String? file});
}

/// @nodoc
class _$CategoriesModelCopyWithImpl<$Res>
    implements $CategoriesModelCopyWith<$Res> {
  _$CategoriesModelCopyWithImpl(this._self, this._then);

  final CategoriesModel _self;
  final $Res Function(CategoriesModel) _then;

  /// Create a copy of CategoriesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? file = freezed,
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
      nameArabic: freezed == nameArabic
          ? _self.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _self.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CategoriesModel implements CategoriesModel {
  const _CategoriesModel(
      {@JsonKey(name: "id") this.id,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "name_arabic") this.nameArabic,
      @JsonKey(name: "file") this.file});
  factory _CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  @override
  @JsonKey(name: "id")
  final int? id;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "name_arabic")
  final String? nameArabic;
  @override
  @JsonKey(name: "file")
  final String? file;

  /// Create a copy of CategoriesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CategoriesModelCopyWith<_CategoriesModel> get copyWith =>
      __$CategoriesModelCopyWithImpl<_CategoriesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CategoriesModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoriesModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameArabic, nameArabic) ||
                other.nameArabic == nameArabic) &&
            (identical(other.file, file) || other.file == file));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, nameArabic, file);

  @override
  String toString() {
    return 'CategoriesModel(id: $id, name: $name, nameArabic: $nameArabic, file: $file)';
  }
}

/// @nodoc
abstract mixin class _$CategoriesModelCopyWith<$Res>
    implements $CategoriesModelCopyWith<$Res> {
  factory _$CategoriesModelCopyWith(
          _CategoriesModel value, $Res Function(_CategoriesModel) _then) =
      __$CategoriesModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int? id,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "name_arabic") String? nameArabic,
      @JsonKey(name: "file") String? file});
}

/// @nodoc
class __$CategoriesModelCopyWithImpl<$Res>
    implements _$CategoriesModelCopyWith<$Res> {
  __$CategoriesModelCopyWithImpl(this._self, this._then);

  final _CategoriesModel _self;
  final $Res Function(_CategoriesModel) _then;

  /// Create a copy of CategoriesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? nameArabic = freezed,
    Object? file = freezed,
  }) {
    return _then(_CategoriesModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      nameArabic: freezed == nameArabic
          ? _self.nameArabic
          : nameArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _self.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
