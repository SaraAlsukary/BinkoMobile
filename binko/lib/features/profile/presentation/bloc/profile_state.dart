// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  final List<BooksModel> favoredBooks;
  const ProfileState({
    this.favoredBooks = const [],
  });

  ProfileState copyWith({
    List<BooksModel>? favoredBooks,
  }) {
    return ProfileState(
      favoredBooks: favoredBooks ?? this.favoredBooks,
    );
  }
}
