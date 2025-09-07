import 'dart:io';

import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/utils/request_status.dart';
import 'package:binko/core/widgets/main_button.dart';
import 'package:binko/core/widgets/main_text_field.dart';
import 'package:binko/features/auth/presentation/pages/waiting_page.dart';
import 'package:binko/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:binko/core/services/dependecies.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:binko/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CompleteInformationUserPage extends StatefulWidget {
  const CompleteInformationUserPage({super.key});

  @override
  State<CompleteInformationUserPage> createState() =>
      _CompleteInformationUserPageState();
}

class _CompleteInformationUserPageState
    extends State<CompleteInformationUserPage> {
  final ageController = TextEditingController();
  final bioController = TextEditingController();
  final ValueNotifier<bool> isReader = ValueNotifier(false);
  late final AuthBloc authBloc;

  File? pickedImage;

  @override
  void initState() {
    super.initState();
    authBloc = getIt<AuthBloc>();
    final currentUser = authBloc.state.user;
    if (currentUser != null) {
      ageController.text = currentUser.age?.toString() ?? '';
      bioController.text = currentUser.discriptions ?? '';
      isReader.value = currentUser.isReader ?? false;
    }
  }

  @override
  void dispose() {
    ageController.dispose();
    bioController.dispose();
    isReader.dispose();
    super.dispose();
  }

  Future<void> pickPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Your Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state.updateProfileState == RequestStatus.success) {
              final user = state.user ?? authBloc.state.user;
              if (user?.isAccept == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const WaitingPage()),
                );
              }
            } else if (state.updateProfileState == RequestStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to update profile")),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.updateProfileState == RequestStatus.loading;
            final currentUser = state.user ?? authBloc.state.user;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  .05.sh.verticalSpace,
                  Center(
                    child: GestureDetector(
                      onTap: pickPicture,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: pickedImage != null
                            ? FileImage(pickedImage!)
                            : (currentUser?.image != null &&
                            currentUser!.image!.isNotEmpty)
                            ? NetworkImage(currentUser.image!)
                            : null,
                        child: pickedImage == null &&
                            (currentUser?.image == null ||
                                currentUser!.image!.isEmpty)
                            ? const Icon(Icons.add_a_photo, size: 40)
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  FractionallySizedBox(
                    widthFactor: .7,
                    child: LottieBuilder.asset(
                      Assets.assetsLottieFilesFlyingBook,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  MainTextField(
                    hintSize: 24.sp,
                    controller: ageController,
                    hint: "Age",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.h),
                  MainTextField(
                    maxLines: 4,
                    hintSize: 24.sp,
                    controller: bioController,
                    hint: "Bio / Description",
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        "Are you a reader?",
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(width: 25.w),
                      ValueListenableBuilder<bool>(
                        valueListenable: isReader,
                        builder: (context, value, _) {
                          return Switch(
                            value: value,
                            onChanged: (val) => isReader.value = val,
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 35.h),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : MainButton(
                    width: 140.w,
                    text: "Save",
                    onPressed: () {
                      final body = {
                        "age": int.tryParse(ageController.text) ?? 0,
                        "discriptions": bioController.text,
                        "is_reader": isReader.value,
                      };

                      authBloc.add(
                        UpdateProfileInfo(body, image: pickedImage),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
