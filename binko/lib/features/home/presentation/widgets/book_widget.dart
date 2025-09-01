// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:binko/core/constants/assets.dart';
import 'package:binko/core/unified_api/api_variables.dart';
import 'package:binko/features/book/data/models/books_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../book/presentation/pages/book_details_screen.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({
    super.key,
    required this.book,
  });

  final BooksModel book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      book: book,
                    )));
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
              child: book.name == null
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
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                book.name ?? '',
                style: context.textTheme.titleLarge!,
              ),
            ),
          ),
          2.verticalSpace,
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                DateFormat.yMMMd(context.locale.languageCode)
                    .format(book.pubDat ?? DateTime.now()),
                style: context.textTheme.titleSmall!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
