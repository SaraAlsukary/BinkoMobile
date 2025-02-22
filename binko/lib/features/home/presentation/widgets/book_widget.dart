import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/details_screen.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsScreen()));
      },
      child: Column(
        children: [
          Expanded(
            child: Card(
              elevation: 6,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(
                Assets.assetsImgsBooksAshin,
                fit: BoxFit.cover,
              ),
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'Title',
                style: context.textTheme.titleLarge!,
              ),
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'author',
                style: context.textTheme.titleSmall!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
