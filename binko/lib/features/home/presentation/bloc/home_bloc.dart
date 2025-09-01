// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/utils/toaster.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/domain/usecases/get_all_books_usecase.dart';
import 'package:binko/features/category/domain/usecases/get_all_categories_usecase.dart';
import 'package:binko/features/home/data/models/categories_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllCategoriesUsecase getAllCategoriesUsecase;
  final GetAllBooksUsecase getAllBooksUsecase;

  HomeBloc(
    this.getAllCategoriesUsecase,
    this.getAllBooksUsecase,
  ) : super(HomeState()) {
    on<GetHomeCategoriesEvent>((event, emit) async {
      emit(state.copyWith(categoriesStatus: RequestStatus.loading));
      final result = await getAllCategoriesUsecase.call(NoParams());
      result.fold((left) {
        emit(state.copyWith(categoriesStatus: RequestStatus.failed));
        Toaster.showToast(left.message);
      }, (right) {
        emit(state.copyWith(
            categoriesStatus: RequestStatus.success, categories: right));
      });
    });

    on<GetHomeBooksEvent>((event, emit) async {
      emit(state.copyWith(booksStatus: RequestStatus.loading));
      final result = await getAllBooksUsecase.call(NoParams());
      result.fold((left) {
        emit(state.copyWith(booksStatus: RequestStatus.failed));
        Toaster.showToast(left.message);
      }, (right) {
        emit(state.copyWith(booksStatus: RequestStatus.success, books: right));
      });
    });
  }
}
