import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:binko/core/extensions/string_parser.dart';
import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/core/utils/theme/light/light_theme.dart';
import 'package:binko/features/book/presentation/pages/add_book_page.dart';
import 'package:binko/features/book/presentation/pages/all_book_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/cubit/theme_cubit.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/dependecies.dart';
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
            // Colors for nav
            final Color selectedColor = context.primaryColor;
            final Color unselectedColor = Colors.grey.shade600;

            // helper to load svg with color
            Widget svgIcon(String assetPath, Color color, {double size = 24}) {
              return SvgPicture.asset(
                assetPath,
                width: size,
                height: size,
                color: color,
                // allow SvgPicture to respect color
                fit: BoxFit.scaleDown,
              );
            }

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
                        underline: const SizedBox(),
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
                                ? const MaterialStatePropertyAll(
                                    Icon(Icons.light_mode))
                                : const MaterialStatePropertyAll(
                                    Icon(Icons.dark_mode)),
                            value: themeState is DarkTheme,
                            activeColor: context.primaryColor,
                            onChanged: (value) {
                              ThemeSwitcher.of(context).changeTheme(
                                theme: themeState is! DarkTheme
                                    ? MaterialTheme('Markazi').dark()
                                    : MaterialTheme('Markazi').light(),
                              );
                              getIt<ThemeCubit>().toggleTheme();
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    BlocBuilder<AuthBloc, AuthState>(
                      bloc: getIt<AuthBloc>(),
                      builder: (context, authState) {
                        if (authState.user != null) {
                          return ListTile(
                            leading:
                                const Icon(Icons.logout, color: Colors.red),
                            title: Text(
                              'profile.logout'.tr(),
                              style: const TextStyle(color: Colors.red),
                            ),
                            onTap: () {
                              getIt<AuthBloc>().add(LogoutEvent());
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              body: IndexedStack(
                index: state.currentIndex,
                children: [
                  const HomeScreen(),

                  // Favorites screen (ProfileBloc)
                  Scaffold(
                    body: BlocBuilder<ProfileBloc, ProfileState>(
                      bloc: getIt<ProfileBloc>(),
                      builder: (context, pState) {
                        return pState.favoredBooks.isEmpty
                            ? Center(
                                child: Text('profile.no_favored_books'.tr()),
                              )
                            : ListView.builder(
                                itemCount: pState.favoredBooks.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      height: 120,
                                      width: 60,
                                      child: Image.network(
                                        pState.favoredBooks[index].image ?? '',
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset(Assets.assetsImgsLogo),
                                      ),
                                    ),
                                    title: Text(
                                      pState.favoredBooks[index].name ?? '',
                                      style: context.textTheme.titleMedium,
                                    ),
                                    trailing: Icon(
                                      Icons.bookmark_remove_outlined,
                                      color: Colors.red,
                                    ).onTap(() {
                                      getIt<ProfileBloc>().add(
                                        DeleteFromFavroed(
                                          id: pState.favoredBooks[index].id!,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    bloc: getIt<AuthBloc>(),
                    builder: (context, authState) {
                      final user = authState.user;
                      if (user?.isReader == true) {
                        return const AllBookPage();
                      }
                      return const AddBookPage();
                    },
                  ),
                  const ProfileScreen(),
                ],
              ),
              bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
                bloc: getIt<AuthBloc>(),
                builder: (context, authState) {
                  final user = authState.user;
                  final isReader = user?.isReader == true;

                  return BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: state.currentIndex,
                    onTap: (value) => getIt<MainCubit>().changeIndex(value),
                    backgroundColor: context.scaffoldBackgroundColor,
                    // use these (don't use fixedColor)
                    selectedItemColor: selectedColor,
                    unselectedItemColor: unselectedColor,

                    items: [
                      BottomNavigationBarItem(
                        icon: svgIcon(
                          Assets.assetsSvgsHome,
                          state.currentIndex == 0
                              ? selectedColor
                              : unselectedColor,
                        ),
                        label: 'navigation.home'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: svgIcon(
                          Assets.assetsSvgsBookMark,
                          state.currentIndex == 1
                              ? selectedColor
                              : unselectedColor,
                        ),
                        label: 'profile.my_favorite'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: isReader
                            ? svgIcon(
                                Assets.assetsSvgsRead,
                                state.currentIndex == 2
                                    ? selectedColor
                                    : unselectedColor,
                              )
                            : svgIcon(
                                Assets.assetsSvgsAddBook,
                                state.currentIndex == 2
                                    ? selectedColor
                                    : unselectedColor,
                              ),
                        label: isReader
                            ? 'navigation.all_books'.tr()
                            : 'navigation.add_book'.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: user?.image != null && user!.image!.isNotEmpty
                            ? CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(user.image!),
                                backgroundColor: Colors.transparent,
                              )
                            : Icon(
                                Icons.person,
                                color: state.currentIndex == 3
                                    ? selectedColor
                                    : unselectedColor,
                              ),
                        label: 'navigation.profile'.tr(),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search.title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            MainTextField(
              prefixIcon: SvgPicture.asset(
                Assets.assetsSvgsSearch,
                width: 22,
                height: 22,
                color: Colors.grey.shade600,
              ),
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
                  title: const Text('The Song of Ice And Fire'),
                  subtitle: const Text('George R.R Martin'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
