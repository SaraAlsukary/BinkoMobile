import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/widget_extensions.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('profile.title'.tr()),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: .5.sh,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: getIt<AuthBloc>(),
                    builder: (context, state) {
                      return Container(
                        width: .50.sw,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        clipBehavior: Clip.hardEdge,
                        alignment: Alignment.center,
                        child: state.user?.image != null
                            ? Image.network(
                          ApiVariables().imageUrl(state.user!.image!),
                          fit: BoxFit.cover,
                          width: .5.sw,
                          height: .5.sw,
                        )
                            : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '+',
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                      );
                    },
                  )),
              SizedBox(
                  height: .5.sh,
                  child: Column(
                    children: [
                      TabBar(
                          isScrollable: true,
                          overlayColor: WidgetStateColor.resolveWith(
                                (states) => context.primaryColor,
                          ),
                          tabs: [
                            Tab(
                              text: 'profile.settings'.tr(),
                            ),
                            Tab(
                              text: 'profile.my_favorite'.tr(),
                            ),
                            Tab(
                              text: 'profile.my_published_books'.tr(),
                            ),
                          ]),
                      Expanded(
                        child: TabBarView(children: [
                          BlocConsumer<AuthBloc, AuthState>(
                            bloc: getIt<AuthBloc>(),
                            listener: (context, state) {},
                            builder: (context, state) {
                              var bioController = TextEditingController(
                                  text: state.user?.discriptions);
                              var userController =
                              TextEditingController(text: state.user?.name);
                              return Container(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MainTextField(
                                      label: 'profile.bio'.tr(),
                                      controller: bioController,
                                    ),
                                    20.verticalSpace,
                                    MainTextField(
                                      label: 'profile.username'.tr(),
                                      controller: userController,
                                    ),
                                    20.verticalSpace,
                                    MainButton(
                                        text: 'profile.change'.tr(),
                                        onPressed: () {
                                          // getIt<AuthBloc>().add();
                                          // UpdateProfileInfo(
                                          //     name: userController.text,
                                          //     description:
                                          //         bioController.text,
                                          //     image: ''));
                                        }
                                    ),
                                    10.verticalSpace,
                                    MainButton(
                                        borderColor: context.primaryColor,
                                        textColor: context.primaryColor,
                                        color: context.scaffoldBackgroundColor,
                                        hasBorder: true,
                                        onPressed: () {
                                          getIt<AuthBloc>().add(LogoutEvent());
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                                  FadeTransition(
                                                    opacity: animation,
                                                    child: SplashScreen(),
                                                  ),
                                            ),
                                                (route) => false,
                                          );
                                        },
                                        text: 'profile.logout'.tr())
                                  ],
                                ),
                              );
                            },
                          ),
                          BlocBuilder<ProfileBloc, ProfileState>(
                            bloc: getIt<ProfileBloc>(),
                            builder: (context, state) {
                              return state.favoredBooks.isEmpty
                                  ? Center(
                                child:
                                Text('profile.no_favored_books'.tr()),
                              )
                                  : ListView.builder(
                                itemCount: state.favoredBooks.length,
                                itemBuilder: (context, index) =>
                                    Padding(
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
                                            state.favoredBooks[index].image ??
                                                '',
                                            errorBuilder: (context, error,
                                                stackTrace) =>
                                                Image.asset(
                                                    Assets.assetsImgsLogo),
                                          ),
                                        ),
                                        title: Text(
                                          state.favoredBooks[index].name ??
                                              '',
                                          style:
                                          context.textTheme.titleMedium,
                                        ),
                                        trailing: Icon(
                                          Icons.bookmark_remove_outlined,
                                          color: Colors.red,
                                        ).onTap(() {
                                          getIt<ProfileBloc>().add(
                                              DeleteFromFavroed(
                                                  id: state
                                                      .favoredBooks[index]
                                                      .id!));
                                        }),
                                      ),
                                    ),
                              );
                            },
                          ),
                          SizedBox(),
                        ]),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
