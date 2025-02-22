import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:binko/core/extensions/string_parser.dart';
import 'package:binko/features/home/presentation/pages/home_screen.dart';
import 'package:binko/features/main/presentation/cubit/main_cubit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependecies.dart';
import '../../../profile/presentation/pages/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      bloc: getIt<MainCubit>(),
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: [
              HomeScreen(),
              Scaffold(
                appBar: AppBar(
                  title: Text('Search Screen'),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text('Bookmarks Screen'),
                ),
              ),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
              index: state.currentIndex,
              onTap: (value) => getIt<MainCubit>().changeIndex(value),
              color: context.primaryColor,
              backgroundColor: context.scaffoldBackgroundColor,
              buttonBackgroundColor: context.theme.colorScheme.onInverseSurface,
              items: [
                Assets.assetsSvgsHome.toSvg(),
                Assets.assetsSvgsSearch.toSvg(),
                Assets.assetsSvgsBookMark.toSvg(),
                Icon(Icons.person)
              ]),
        );
      },
    );
  }
}
