import 'package:binko/core/utils/request_status.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        icon: Icon(Icons.refresh),
                        tooltip: 'category.refresh'.tr()),
                  )
                : GridView.builder(
                    itemCount: state.categoriesStatus == RequestStatus.loading
                        ? 12
                        : state.categories.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              child: Text(state.categories[index].name!),
                            );
                    },
                  );
          },
        ));
  }
}
