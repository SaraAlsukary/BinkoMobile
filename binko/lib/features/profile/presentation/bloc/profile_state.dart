// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  final List<BooksModel> favoredBooks;
  final int? age;
  final String? discriptions;
  final bool? isReader;
  final RequestStatus updateProfileState;

  const ProfileState({
    this.favoredBooks = const [],
    this.age,
    this.discriptions,
    this.isReader,
    this.updateProfileState = RequestStatus.init,
  });

  ProfileState copyWith({
    List<BooksModel>? favoredBooks,
    int? age,
    String? discriptions,
    bool? isReader,
    RequestStatus? updateProfileState,
  }) {
    return ProfileState(
      favoredBooks: favoredBooks ?? this.favoredBooks,
      age: age ?? this.age,
      discriptions: discriptions ?? this.discriptions,
      isReader: isReader ?? this.isReader,
      updateProfileState: updateProfileState ?? this.updateProfileState,
    );
  }
}
