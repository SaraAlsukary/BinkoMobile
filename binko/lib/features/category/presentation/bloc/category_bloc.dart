// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/usecase/usecase.dart';
import 'package:binko/features/category/domain/usecases/add_categories_use_case.dart';
import 'package:binko/features/category/domain/usecases/get_all_categories_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/request_status.dart';
import '../../../home/data/models/categories_model.dart';

part 'category_event.dart';
part 'category_state.dart';

@lazySingleton
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUsecase getAllCategoriesUsecase;
  final AddCategoryUsecase addCategoryUsecase;

  CategoryBloc(
    this.getAllCategoriesUsecase,
    this.addCategoryUsecase,
  ) : super(CategoryState()) {
    on<GetAllCategoriesEvent>((event, emit) async {
      emit(state.copyWith(categoriesStatus: RequestStatus.loading));
      final result = await getAllCategoriesUsecase.call(NoParams());
      result.fold(
        (left) => emit(state.copyWith(categoriesStatus: RequestStatus.failed)),
        (right) => emit(state.copyWith(
          categoriesStatus: RequestStatus.success,
          categories: right,
        )),
      );
    });

    // on<AddCategoryEvent>((event, emit) async {
    //   emit(state.copyWith(addCategoryStatus: RequestStatus.loading));
    //   print("loaaaaaaaaaaaaaaaaaaaad");
    //   final result = await addCategoryUsecase.call(AddCategoryParams(
    //     name: event.name,
    //     nameArabic: event.nameArabic,
    //   ));
    //
    //   result.fold(
    //     (failure) {
    //       print("fffailure add");
    //       emit(state.copyWith(
    //         addCategoryStatus: RequestStatus.failed,
    //       ));
    //     },
    //     (category) {
    //       print("succcccccccccc");
    //       final updatedList = List<CategoriesModel>.from(state.categories)
    //         ..add(category);
    //       emit(state.copyWith(
    //         addCategoryStatus: RequestStatus.success,
    //         categories: updatedList,
    //       ));
    //     },
    //   );
    // });
    on<AddCategoryEvent>((event, emit) async {
      emit(state.copyWith(addCategoryStatus: RequestStatus.loading));
      try {
        final result = await addCategoryUsecase.call(AddCategoryParams(
          name: event.name,
          nameArabic: event.nameArabic,
        ));

        result.fold(
          (failure) {
            print("Failure add: $failure");
            emit(state.copyWith(addCategoryStatus: RequestStatus.failed));
          },
          (category) {
            print("Success add: $category");
            final updatedList = List<CategoriesModel>.from(state.categories)
              ..add(category);
            emit(state.copyWith(
              addCategoryStatus: RequestStatus.success,
              categories: updatedList,
            ));
          },
        );
      } catch (e) {
        print("Exception during add: $e");
        emit(state.copyWith(addCategoryStatus: RequestStatus.failed));
      }
    });
  }
}
