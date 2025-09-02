// category_screen.dart
import 'package:binko/core/utils/request_status.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/services/dependecies.dart';
import '../../../home/presentation/widgets/container_widget.dart';
import '../bloc/category_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    getIt<CategoryBloc>().add(GetAllCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('category.title'.tr()),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        bloc: getIt<CategoryBloc>(),
        builder: (context, state) {
          return state.categoriesStatus == RequestStatus.failed
              ? Center(
                  child: IconButton.filled(
                      onPressed: () {
                        getIt<CategoryBloc>().add(GetAllCategoriesEvent());
                      },
                      icon: const Icon(Icons.refresh),
                      tooltip: 'category.refresh'.tr()),
                )
              : GridView.builder(
                  itemCount: state.categoriesStatus == RequestStatus.loading
                      ? 12
                      : state.categories.length,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return state.categoriesStatus == RequestStatus.loading
                        ? Skeletonizer(
                            enabled: true,
                            child: MultiColorBorderContainer(
                              child: Text('home.action'.tr()),
                            ))
                        : MultiColorBorderContainer(
                            child: Text(state.categories[index].name!,style: TextStyle(fontSize:22.h, ),),
                          );
                  },
                );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _showAddCategoryDialog(context),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  // void _showAddCategoryDialog(BuildContext context) {
  //   final nameController = TextEditingController();
  //   final nameArabicController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('category.add_new'.tr()),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           TextField(
  //             controller: nameController,
  //             decoration: InputDecoration(
  //               labelText: 'category.name'.tr(),
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           TextField(
  //             controller: nameArabicController,
  //             decoration: InputDecoration(
  //               labelText: 'category.name_arabic'.tr(),
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //         ],
  //       ),
  //       // actions: [
  //       //   TextButton(
  //       //     onPressed: () => Navigator.pop(context),
  //       //     child: Text('common.cancel'.tr()),
  //       //   ),
  //       //   BlocConsumer<CategoryBloc, CategoryState>(
  //       //     bloc: getIt<CategoryBloc>(),
  //       //     listener: (context, state) {
  //       //       if (state.addCategoryStatus == RequestStatus.success) {
  //       //         Navigator.pop(context);
  //       //       }
  //       //     },
  //       //     builder: (context, state) {
  //       //       return ElevatedButton(
  //       //         onPressed: state.addCategoryStatus == RequestStatus.loading
  //       //             ? null
  //       //             : () {
  //       //                 if (nameController.text.isNotEmpty &&
  //       //                     nameArabicController.text.isNotEmpty) {
  //       //                   getIt<CategoryBloc>().add(AddCategoryEvent(
  //       //                     name: nameController.text,
  //       //                     nameArabic: nameArabicController.text,
  //       //                   ));
  //       //                 }
  //       //               },
  //       //         child: state.addCategoryStatus == RequestStatus.loading
  //       //             ? const CircularProgressIndicator()
  //       //             : Text('common.add'.tr()),
  //       //       );
  //       //     },
  //       //   ),
  //       // ],
  //     ),
  //   );
  // }
}
