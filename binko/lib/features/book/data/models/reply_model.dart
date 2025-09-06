import 'package:freezed_annotation/freezed_annotation.dart';


part 'reply_model.freezed.dart';
part 'reply_model.g.dart';


@freezed
sealed class ReplyModel with _$ReplyModel {
  const factory ReplyModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'user') int? userId,
    @JsonKey(name: 'name') String? userName,
    @JsonKey(name: 'image') String? userImage,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'comment') int? commentId,
    @JsonKey(name: 'parent') int? parentId,
  }) = _ReplyModel;


  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);
}