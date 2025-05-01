part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeCategoriesEvent extends HomeEvent {}

class GetHomeBooksEvent extends HomeEvent {}
