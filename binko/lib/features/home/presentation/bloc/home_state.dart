// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState {
  final RequestStatus categoriesStatus;
  final RequestStatus booksStatus;
  final List<CategoriesModel> categories;
  final List<BooksModel> books;

  HomeState({
    this.categoriesStatus = RequestStatus.init,
    this.booksStatus = RequestStatus.init,
    this.categories = const [],
    this.books = const [],
  });

  HomeState copyWith({
    RequestStatus? categoriesStatus,
    RequestStatus? booksStatus,
    List<CategoriesModel>? categories,
    List<BooksModel>? books,
  }) {
    return HomeState(
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      booksStatus: booksStatus ?? this.booksStatus,
      categories: categories ?? this.categories,
      books: books ?? this.books,
    );
  }
}
