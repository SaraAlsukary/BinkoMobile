// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

class CategoryState {
  const CategoryState({
    this.categoriesStatus = RequestStatus.init,
    this.categories = const [],
  });
  final RequestStatus categoriesStatus;
  final List<CategoriesModel> categories;

  CategoryState copyWith({
    RequestStatus? categoriesStatus,
    List<CategoriesModel>? categories,
  }) {
    return CategoryState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
    );
  }
}
