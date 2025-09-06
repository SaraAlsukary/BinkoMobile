// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'books_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BooksModel {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'name')
  String? get name;
  @JsonKey(name: 'image')
  String? get image;
  @JsonKey(name: 'user')
  AuthorModel? get author;
  @JsonKey(name: 'description')
  String? get description;
  @JsonKey(name: 'content')
  String? get content;
  @JsonKey(name: 'publication_date')
  DateTime? get pubDat;
  @JsonKey(name: 'categories')
  List<String>? get categories;
  @JsonKey(name: 'is_accept')
  bool? get isAccept;
  @JsonKey(name: 'language')
  String? get language;

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BooksModelCopyWith<BooksModel> get copyWith =>
      _$BooksModelCopyWithImpl<BooksModel>(this as BooksModel, _$identity);

  /// Serializes this BooksModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BooksModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.pubDat, pubDat) || other.pubDat == pubDat) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            (identical(other.isAccept, isAccept) ||
                other.isAccept == isAccept) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      image,
      author,
      description,
      content,
      pubDat,
      const DeepCollectionEquality().hash(categories),
      isAccept,
      language);

  @override
  String toString() {
    return 'BooksModel(id: $id, name: $name, image: $image, author: $author, description: $description, content: $content, pubDat: $pubDat, categories: $categories, isAccept: $isAccept, language: $language)';
  }
}

/// @nodoc
abstract mixin class $BooksModelCopyWith<$Res> {
  factory $BooksModelCopyWith(
          BooksModel value, $Res Function(BooksModel) _then) =
      _$BooksModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'image') String? image,
      @JsonKey(name: 'user') AuthorModel? author,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'publication_date') DateTime? pubDat,
      @JsonKey(name: 'categories') List<String>? categories,
      @JsonKey(name: 'is_accept') bool? isAccept,
      @JsonKey(name: 'language') String? language});

  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class _$BooksModelCopyWithImpl<$Res> implements $BooksModelCopyWith<$Res> {
  _$BooksModelCopyWithImpl(this._self, this._then);

  final BooksModel _self;
  final $Res Function(BooksModel) _then;

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? pubDat = freezed,
    Object? categories = freezed,
    Object? isAccept = freezed,
    Object? language = freezed,
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
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      pubDat: freezed == pubDat
          ? _self.pubDat
          : pubDat // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categories: freezed == categories
          ? _self.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isAccept: freezed == isAccept
          ? _self.isAccept
          : isAccept // ignore: cast_nullable_to_non_nullable
              as bool?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _BooksModel implements BooksModel {
  _BooksModel(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'image') this.image,
      @JsonKey(name: 'user') this.author,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'publication_date') this.pubDat,
      @JsonKey(name: 'categories') final List<String>? categories,
      @JsonKey(name: 'is_accept') this.isAccept,
      @JsonKey(name: 'language') this.language})
      : _categories = categories;
  factory _BooksModel.fromJson(Map<String, dynamic> json) =>
      _$BooksModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'image')
  final String? image;
  @override
  @JsonKey(name: 'user')
  final AuthorModel? author;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'publication_date')
  final DateTime? pubDat;
  final List<String>? _categories;
  @override
  @JsonKey(name: 'categories')
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'is_accept')
  final bool? isAccept;
  @override
  @JsonKey(name: 'language')
  final String? language;

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BooksModelCopyWith<_BooksModel> get copyWith =>
      __$BooksModelCopyWithImpl<_BooksModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BooksModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BooksModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.pubDat, pubDat) || other.pubDat == pubDat) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.isAccept, isAccept) ||
                other.isAccept == isAccept) &&
            (identical(other.language, language) ||
                other.language == language));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      image,
      author,
      description,
      content,
      pubDat,
      const DeepCollectionEquality().hash(_categories),
      isAccept,
      language);

  @override
  String toString() {
    return 'BooksModel(id: $id, name: $name, image: $image, author: $author, description: $description, content: $content, pubDat: $pubDat, categories: $categories, isAccept: $isAccept, language: $language)';
  }
}

/// @nodoc
abstract mixin class _$BooksModelCopyWith<$Res>
    implements $BooksModelCopyWith<$Res> {
  factory _$BooksModelCopyWith(
          _BooksModel value, $Res Function(_BooksModel) _then) =
      __$BooksModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'image') String? image,
      @JsonKey(name: 'user') AuthorModel? author,
      @JsonKey(name: 'description') String? description,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'publication_date') DateTime? pubDat,
      @JsonKey(name: 'categories') List<String>? categories,
      @JsonKey(name: 'is_accept') bool? isAccept,
      @JsonKey(name: 'language') String? language});

  @override
  $AuthorModelCopyWith<$Res>? get author;
}

/// @nodoc
class __$BooksModelCopyWithImpl<$Res> implements _$BooksModelCopyWith<$Res> {
  __$BooksModelCopyWithImpl(this._self, this._then);

  final _BooksModel _self;
  final $Res Function(_BooksModel) _then;

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? content = freezed,
    Object? pubDat = freezed,
    Object? categories = freezed,
    Object? isAccept = freezed,
    Object? language = freezed,
  }) {
    return _then(_BooksModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AuthorModel?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      pubDat: freezed == pubDat
          ? _self.pubDat
          : pubDat // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categories: freezed == categories
          ? _self._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isAccept: freezed == isAccept
          ? _self.isAccept
          : isAccept // ignore: cast_nullable_to_non_nullable
              as bool?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of BooksModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<$Res>? get author {
    if (_self.author == null) {
      return null;
    }

    return $AuthorModelCopyWith<$Res>(_self.author!, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc
mixin _$AuthorModel {
  @JsonKey(name: 'id')
  int? get id;
  @JsonKey(name: 'name')
  String? get name;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthorModelCopyWith<AuthorModel> get copyWith =>
      _$AuthorModelCopyWithImpl<AuthorModel>(this as AuthorModel, _$identity);

  /// Serializes this AuthorModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthorModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'AuthorModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $AuthorModelCopyWith<$Res> {
  factory $AuthorModelCopyWith(
          AuthorModel value, $Res Function(AuthorModel) _then) =
      _$AuthorModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$AuthorModelCopyWithImpl<$Res> implements $AuthorModelCopyWith<$Res> {
  _$AuthorModelCopyWithImpl(this._self, this._then);

  final AuthorModel _self;
  final $Res Function(AuthorModel) _then;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AuthorModel implements AuthorModel {
  _AuthorModel(
      {@JsonKey(name: 'id') this.id, @JsonKey(name: 'name') this.name});
  factory _AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'name')
  final String? name;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthorModelCopyWith<_AuthorModel> get copyWith =>
      __$AuthorModelCopyWithImpl<_AuthorModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuthorModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthorModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'AuthorModel(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$AuthorModelCopyWith<$Res>
    implements $AuthorModelCopyWith<$Res> {
  factory _$AuthorModelCopyWith(
          _AuthorModel value, $Res Function(_AuthorModel) _then) =
      __$AuthorModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$AuthorModelCopyWithImpl<$Res> implements _$AuthorModelCopyWith<$Res> {
  __$AuthorModelCopyWithImpl(this._self, this._then);

  final _AuthorModel _self;
  final $Res Function(_AuthorModel) _then;

  /// Create a copy of AuthorModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_AuthorModel(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
