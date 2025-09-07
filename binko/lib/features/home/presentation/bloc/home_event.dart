part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeCategoriesEvent extends HomeEvent {}

class GetHomeBooksEvent extends HomeEvent {}

class GetBooksByCategoryEvent extends HomeEvent {
  final int categoryId;

  const GetBooksByCategoryEvent(this.categoryId);
}
