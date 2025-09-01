import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter_model.freezed.dart';
part 'chapter_model.g.dart';

@freezed
sealed class ChapterModel with _$ChapterModel {
  const factory ChapterModel(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'content_text') String? content,
      @JsonKey(name: 'audio') String? audio}) = _ChapterModel;

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);
}
