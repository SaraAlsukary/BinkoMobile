import 'package:freezed_annotation/freezed_annotation.dart';

part 'books_model.freezed.dart';
part 'books_model.g.dart';

@freezed
sealed class BooksModel with _$BooksModel {
  factory BooksModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'user') AuthorModel? author,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'publication_date') DateTime? pubDat,
  }) = _BooksModel;
  factory BooksModel.fromJson(Map<String, dynamic> json) =>
      _$BooksModelFromJson(json);
}

@freezed
sealed class AuthorModel with _$AuthorModel {
  factory AuthorModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
  }) = _AuthorModel;
  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
}
