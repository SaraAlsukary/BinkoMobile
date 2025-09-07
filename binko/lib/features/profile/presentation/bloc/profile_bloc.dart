import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/profile/data/repositories/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/dependecies.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<GetFavoredBooks>((event, emit) async {
      final result = await ProfileRepo().getFavoredBooks();
      result.fold((left) {}, (right) {
        emit(state.copyWith(favoredBooks: right));
      });
    });
    on<AddToFavroed>((event, emit) async {
      final result = await ProfileRepo().addToFavored(
          event.booksModel.id!, getIt<AuthBloc>().state.user!.id!);
      result.fold((left) {}, (right) {
        emit(state.copyWith(
            favoredBooks: List.from(state.favoredBooks)
              ..add(event.booksModel)));
      });
    });
    on<DeleteFromFavroed>((event, emit) async {
      final result = await ProfileRepo()
          .deleteFromFavored(event.id, getIt<AuthBloc>().state.user!.id!);
      result.fold((left) {}, (right) {
        emit(state.copyWith(
            favoredBooks: List.from(state.favoredBooks)
              ..removeWhere((e) => e.id == event.id)));
      });
    });
  }
}
