import 'dart:io';

import 'package:binko/core/error/failures.dart';
import 'package:binko/features/book/data/models/chapter_model.dart';
import 'package:binko/features/book/domain/repositories/books_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@lazySingleton
class AddChapterUseCase {
  final BooksRepo repo;

  AddChapterUseCase(this.repo);

  Future<Either<Failure, ChapterModel>> call({
    required int bookId,
    String? title,
    String? content,
    File? audioFile,
  }) async {
    return await repo.addChapter(
      bookId: bookId,
      title: title,
      content: content,
      audioFile: audioFile,
    );
  }
}
