part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final RequestStatus categoriesStatus;
  final List<CategoriesModel> categories;

  final RequestStatus addCategoryStatus;

  const CategoryState({
    this.categoriesStatus = RequestStatus.init,
    this.categories = const [],
    this.addCategoryStatus = RequestStatus.init,
  });

  CategoryState copyWith({
    RequestStatus? categoriesStatus,
    List<CategoriesModel>? categories,
    RequestStatus? addCategoryStatus,
  }) {
    return CategoryState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      categories: categories ?? this.categories,
      addCategoryStatus: addCategoryStatus ?? this.addCategoryStatus,
    );
  }

  @override
  List<Object?> get props => [categoriesStatus, categories, addCategoryStatus];
}
