// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/book/data/datasources/books_datasource.dart' as _i1028;
import '../../features/book/data/repositories/books_repo__impl.dart' as _i446;
import '../../features/book/domain/repositories/books_repo.dart' as _i125;
import '../../features/book/domain/usecases/get_all_books_usecase.dart'
    as _i140;
import '../../features/book/domain/usecases/get_book_chapters_usecase.dart'
    as _i371;
import '../../features/book/presentation/bloc/book_bloc.dart' as _i86;
import '../../features/category/data/datasources/categories_datasource.dart'
    as _i276;
import '../../features/category/data/repositories/categories_repo_impl.dart'
    as _i175;
import '../../features/category/domain/repositories/categories_repository.dart'
    as _i471;
import '../../features/category/domain/usecases/get_all_categories_usecase.dart'
    as _i273;
import '../../features/category/presentation/bloc/category_bloc.dart' as _i292;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/main/presentation/cubit/main_cubit.dart' as _i552;
import '../../features/profile/presentation/bloc/profile_bloc.dart' as _i469;
import '../cubit/theme_cubit.dart' as _i319;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1028.RemoteBookDatasource>(
        () => _i1028.RemoteBookDatasource());
    gh.factory<_i276.RemoteCategoryDatasource>(
        () => _i276.RemoteCategoryDatasource());
    gh.lazySingleton<_i319.ThemeCubit>(() => _i319.ThemeCubit());
    gh.lazySingleton<_i797.AuthBloc>(() => _i797.AuthBloc());
    gh.lazySingleton<_i552.MainCubit>(() => _i552.MainCubit());
    gh.lazySingleton<_i469.ProfileBloc>(() => _i469.ProfileBloc());
    gh.factory<_i125.BooksRepo>(() =>
        _i446.BooksRepoImpl(datasource: gh<_i1028.RemoteBookDatasource>()));
    gh.factory<_i140.GetAllBooksUsecase>(
        () => _i140.GetAllBooksUsecase(repo: gh<_i125.BooksRepo>()));
    gh.factory<_i371.GetBookChaptersUsecase>(
        () => _i371.GetBookChaptersUsecase(repo: gh<_i125.BooksRepo>()));
    gh.factory<_i471.CategoriesRepository>(() => _i175.CategoriesRepoImpl(
        datasource: gh<_i276.RemoteCategoryDatasource>()));
    gh.lazySingleton<_i86.BookBloc>(() => _i86.BookBloc(
          gh<_i140.GetAllBooksUsecase>(),
          gh<_i371.GetBookChaptersUsecase>(),
        ));
    gh.factory<_i273.GetAllCategoriesUsecase>(() =>
        _i273.GetAllCategoriesUsecase(
            repository: gh<_i471.CategoriesRepository>()));
    gh.lazySingleton<_i202.HomeBloc>(() => _i202.HomeBloc(
          gh<_i273.GetAllCategoriesUsecase>(),
          gh<_i140.GetAllBooksUsecase>(),
        ));
    gh.lazySingleton<_i292.CategoryBloc>(
        () => _i292.CategoryBloc(gh<_i273.GetAllCategoriesUsecase>()));
    return this;
  }
}
