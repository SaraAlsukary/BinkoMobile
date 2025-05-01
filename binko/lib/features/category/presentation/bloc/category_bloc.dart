// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/features/category/domain/usecases/get_all_categories_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/request_status.dart';
import '../../../home/data/models/categories_model.dart';

part 'category_event.dart';
part 'category_state.dart';

@lazySingleton
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUsecase getAllCategoriesUsecase;
  CategoryBloc(
    this.getAllCategoriesUsecase,
  ) : super(CategoryState()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(state.copyWith(categoriesStatus: RequestStatus.loading));
      final result = await getAllCategoriesUsecase.call(NoParams());
      result.fold((left) {
        emit(state.copyWith(categoriesStatus: RequestStatus.failed));
      }, (right) {
        emit(state.copyWith(
            categoriesStatus: RequestStatus.success, categories: right));
      });
    });
  }
}
