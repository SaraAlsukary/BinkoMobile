part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetFavoredBooks extends ProfileEvent {}

class AddToFavroed extends ProfileEvent {
  final BooksModel booksModel;

  const AddToFavroed({required this.booksModel});
}

class DeleteFromFavroed extends ProfileEvent {
  final int id;

  const DeleteFromFavroed({required this.id});
}
class UpdateProfileInfo extends ProfileEvent {
  final Map<String, dynamic> body;
  const UpdateProfileInfo(this.body);
}