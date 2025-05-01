import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_parser.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../cubit/main_cubit.dart';

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
                    icon: Assets.assetsSvgsHome.toSvg(), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile')
              ]),
        );
      },
    );
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
        title: Text('Search Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            MainTextField(
              prefixIcon: Assets.assetsSvgsSearch.toSvg(),
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
