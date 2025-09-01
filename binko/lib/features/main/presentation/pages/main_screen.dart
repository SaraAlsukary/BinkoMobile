import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:binko/features/book/presentation/pages/add_book_page.dart';
import 'package:binko/features/book/presentation/pages/book_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/cubit/theme_cubit.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_parser.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/utils/theme/light/light_theme.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../cubit/main_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.switcher(
        clipper: ThemeSwitcherCircleClipper(),
        builder: (context, switcher) {
          return BlocBuilder<MainCubit, MainState>(
            bloc: getIt<MainCubit>(),
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  forceMaterialTransparency: true,
                  title: Image.asset(Assets.assetsImgsLogo),
                ),
                endDrawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          color: context.primaryColor,
                        ),
                        child: Center(
                          child: Image.asset(
                            Assets.assetsImgsLogo,
                            color: Colors.white,
                            width: 120,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('profile.language'.tr()),
                        trailing: DropdownButton<String>(
                          value: context.locale.languageCode,
                          underline: SizedBox(),
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('profile.english'.tr()),
                            ),
                            DropdownMenuItem(
                              value: 'ar',
                              child: Text('profile.arabic'.tr()),
                            ),
                          ],
                          onChanged: (value) {
                            if (value != null) {
                              context.setLocale(Locale(value));
                            }
                          },
                        ),
                      ),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        bloc: getIt<ThemeCubit>(),
                        builder: (context, themeState) {
                          return ListTile(
                            title: Text('profile.theme'.tr()),
                            trailing: Switch(
                              thumbIcon: themeState is! DarkTheme
                                  ? WidgetStatePropertyAll(
                                      Icon(Icons.light_mode))
                                  : WidgetStatePropertyAll(
                                      Icon(Icons.dark_mode)),
                              value: themeState is DarkTheme,
                              activeColor: context.primaryColor,
                              onChanged: (value) {
                                ThemeSwitcher.of(context).changeTheme(
                                    theme: themeState is! DarkTheme
                                        ? MaterialTheme('Markazi').dark()
                                        : MaterialTheme('Markazi').light());
                                getIt<ThemeCubit>().toggleTheme();
                              },
                            ),
                          );
                        },
                      ),
                      Divider(),
                      BlocBuilder<AuthBloc, AuthState>(
                        bloc: getIt<AuthBloc>(),
                        builder: (context, authState) {
                          if (authState.user != null) {
                            return ListTile(
                              leading: Icon(Icons.logout, color: Colors.red),
                              title: Text(
                                'profile.logout'.tr(),
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: () {
                                getIt<AuthBloc>().add(LogoutEvent());
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                body: IndexedStack(
                  index: state.currentIndex,
                  children: [
                    HomeScreen(),
                    Scaffold(
                      body: BlocBuilder<ProfileBloc, ProfileState>(
                        bloc: getIt<ProfileBloc>(),
                        builder: (context, state) {
                          return state.favoredBooks.isEmpty
                              ? Center(
                                  child: Text('profile.no_favored_books'.tr()),
                                )
                              : ListView.builder(
                                  itemCount: state.favoredBooks.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        height: 120,
                                        width: 60,
                                        child: Image.network(
                                          state.favoredBooks[index].image ?? '',
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                                      Assets.assetsImgsLogo),
                                        ),
                                      ),
                                      title: Text(
                                        state.favoredBooks[index].name ?? '',
                                        style: context.textTheme.titleMedium,
                                      ),
                                      trailing: Icon(
                                        Icons.bookmark_remove_outlined,
                                        color: Colors.red,
                                      ).onTap(() {
                                        getIt<ProfileBloc>().add(
                                            DeleteFromFavroed(
                                                id: state
                                                    .favoredBooks[index].id!));
                                      }),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
                    AddBookPage(),
                    ProfileScreen(),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                    currentIndex: state.currentIndex,
                    onTap: (value) => getIt<MainCubit>().changeIndex(value),
                    fixedColor: context.primaryColor,
                    backgroundColor: context.scaffoldBackgroundColor,
                    items: [
                      BottomNavigationBarItem(
                          icon: Assets.assetsSvgsHome.toSvg(),
                          label: 'navigation.home'.tr()),
                      BottomNavigationBarItem(
                          icon: Assets.assetsSvgsBookMark.toSvg(),
                          label: 'profile.my_favorite'.tr()),
                      BottomNavigationBarItem(
                        icon: Assets.assetsSvgsAddBook.toSvg(),
                        label: 'Book',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          label: 'navigation.profile'.tr()),
                    ]),
              );
            },
          );
        });
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search.title'.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            MainTextField(
              prefixIcon: Assets.assetsSvgsSearch.toSvg(),
              hint: 'search.hint'.tr(),
            ),
            20.verticalSpace,
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(Assets.assetsImgsBooksAshin)),
                title: Text('The Song of Ice And Fire'),
                subtitle: Text('George R.R Martin'),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
