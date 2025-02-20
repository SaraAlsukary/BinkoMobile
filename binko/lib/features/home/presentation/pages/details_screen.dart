import 'package:binko/core/extensions/context_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
  });
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        centerTitle: true,
        title: Text(
          'booky',
          style: context.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.edit,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
          ),
        ),
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                120.verticalSpace,
                SizedBox(
                  width: .4.sw,
                  height: .25.sh,
                  child: Card(
                    elevation: 8,
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Placeholder(),
                  ),
                ),
                10.verticalSpace,
                Text(
                  'Title',
                  style: context.textTheme.titleLarge,
                ),
                10.verticalSpace,
                Text(
                  'Author',
                  style: context.textTheme.titleSmall,
                ),
                10.verticalSpace,
                Text(
                  DateFormat('yyyy - MM - dd').format(DateTime.now()),
                  style: context.textTheme.titleMedium,
                ),
                25.verticalSpace,
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: context.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '',
                      style: context.textTheme.titleMedium
                          ?.copyWith(color: Colors.white),
                    )),
                25.verticalSpace,
                Text(
                  '',
                  textAlign: TextAlign.justify,
                )
              ],
            )),
      ),
    );
  }
}
