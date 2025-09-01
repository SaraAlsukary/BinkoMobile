part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoryEvent {}

class AddCategoryEvent extends CategoryEvent {
  final String name;
  final String nameArabic;

  const AddCategoryEvent({
    required this.name,
    required this.nameArabic,
  });

  @override
  List<Object> get props => [
        name,
        nameArabic,
      ];
}
