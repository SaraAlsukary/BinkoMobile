import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
sealed class CommentModel with _$CommentModel {
  const factory CommentModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'comment') String? comment,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'user_image') String? userImage,
    @JsonKey(name: 'reply_count') int? replyCount,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
