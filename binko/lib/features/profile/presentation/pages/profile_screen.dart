import 'dart:io';

import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/features/book/presentation/bloc/book_bloc.dart';
import 'package:binko/features/book/presentation/pages/book_page.dart';
import 'package:binko/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:binko/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/services/dependecies.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController bioController;
  late TextEditingController ageController;
  late ValueNotifier<bool> isReader;
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    final user = getIt<AuthBloc>().state.user;
    nameController = TextEditingController(text: user?.name ?? "");
    usernameController = TextEditingController(text: user?.username ?? "");
    bioController = TextEditingController(text: user?.discriptions ?? "");
    ageController = TextEditingController(text: user?.age?.toString() ?? "");
    isReader = ValueNotifier(user?.isReader ?? false);

    getIt<BookBloc>().add(GetMyBooksEvent(user!.id!));
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    ageController.dispose();
    isReader.dispose();
    super.dispose();
  }

  void saveChanges() {
    final body = {
      "name": nameController.text,
      "username": usernameController.text,
      "discriptions": bioController.text,
      "age": int.tryParse(ageController.text) ?? 0,
      "is_reader": isReader.value,
    };
    getIt<AuthBloc>().add(UpdateProfileInfo(body, image: pickedImage));
  }

  Widget settingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          MainTextField(label: 'profile.name'.tr(), controller: nameController),
          15.verticalSpace,
          MainTextField(
              label: 'profile.username'.tr(), controller: usernameController),
          15.verticalSpace,
          MainTextField(label: 'profile.bio'.tr(), controller: bioController),
          15.verticalSpace,
          MainTextField(
            label: 'profile.age'.tr(),
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
          15.verticalSpace,
          ValueListenableBuilder(
            valueListenable: isReader,
            builder: (context, value, _) => CheckboxListTile(
              title: Text("profile.is_reader".tr()),
              value: value,
              onChanged: (val) => isReader.value = val ?? false,
            ),
          ),
          30.verticalSpace,
          MainButton(
            width: MediaQuery.of(context).size.width * 0.8,
            text: "profile.change".tr(),
            onPressed: saveChanges,
          ),
          10.verticalSpace,
          MainButton(
            text: "profile.logout".tr(),
            borderColor: Colors.redAccent,
            textColor: Colors.red,
            color: context.scaffoldBackgroundColor,
            hasBorder: true,
            onPressed: () {
              getIt<AuthBloc>().add(LogoutEvent());
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => SplashScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget favoriteTab() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: getIt<ProfileBloc>(),
      builder: (context, state) {
        if (state.favoredBooks.isEmpty) {
          return Center(child: Text('profile.no_favored_books'.tr()));
        }
        return ListView.builder(
          itemCount: state.favoredBooks.length,
          itemBuilder: (context, index) {
            final book = state.favoredBooks[index];
            return ListTile(
              title: Text(book.name ?? ''),
              trailing: IconButton(
                icon: Icon(Icons.bookmark_remove_outlined, color: Colors.red),
                onPressed: () {
                  getIt<ProfileBloc>().add(DeleteFromFavroed(id: book.id!));
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget publishedBooksTab() {
    final user = getIt<AuthBloc>().state.user!;
    return BlocBuilder<BookBloc, BookState>(
      bloc: getIt<BookBloc>(),
      builder: (context, state) {
        if (state.myBooksStatus == RequestStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.myBooksStatus == RequestStatus.failed) {
          return Center(
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getIt<BookBloc>().add(GetMyBooksEvent(user.id!));
              },
            ),
          );
        }
        if (state.myBooks.isEmpty) {
          return Center(child: Text('profile.no_published_books'.tr()));
        }
        return ListView.builder(
          itemCount: state.myBooks.length,
          itemBuilder: (context, index) {
            final book = state.myBooks[index];
            return ListTile(
              leading: book.image != null && book.image!.isNotEmpty
                  ? Image.asset(
                      Assets.assetsImgsBooksImages,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      ApiVariables().imageUrl(book.image ?? ''),
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(Assets.assetsImgsLogo),
                      fit: BoxFit.cover,
                    ),
              title: Text(book.name ?? ''),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BookPage(book: book)),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = getIt<AuthBloc>().state.user;
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final img = await picker.pickImage(source: ImageSource.gallery);
            if (img != null) {
              setState(() {
                pickedImage = File(img.path);
              });
            }
          },
          child: CircleAvatar(
            radius: 70,
            backgroundImage: pickedImage != null
                ? FileImage(pickedImage!)
                : (user?.image != null && user!.image!.isNotEmpty
                    ? NetworkImage(ApiVariables().imageUrl(user.image!))
                    : AssetImage('assets/logo.png')) as ImageProvider,
            child: pickedImage == null &&
                    (user?.image == null || user!.image!.isEmpty)
                ? Icon(Icons.add_a_photo, size: 40)
                : null,
          ),
        ),
        20.verticalSpace,
        Expanded(
          child: ValueListenableBuilder<bool>(
            valueListenable: isReader,
            builder: (context, isReaderUser, _) {
              final tabs = [
                Tab(text: 'profile.settings'.tr()),
                Tab(text: 'profile.my_favorite'.tr()),
                if (!isReaderUser) Tab(text: 'profile.my_published_books'.tr()),
              ];

              final tabViews = [
                settingsTab(),
                favoriteTab(),
                if (!isReaderUser) publishedBooksTab(),
              ];

              return DefaultTabController(
                length: tabs.length,
                child: Column(
                  children: [
                    TabBar(isScrollable: true, tabs: tabs),
                    Expanded(child: TabBarView(children: tabViews)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
