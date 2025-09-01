import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';

class YesNoDialog extends StatelessWidget {
  const YesNoDialog({
    super.key,
    required this.title,
    required this.onTapYes,
    this.onTapNo,
    this.yesTitle,
    this.noTitle,
  });

  final String title;
  final Function() onTapYes;
  final Function()? onTapNo;
  final String? yesTitle;
  final String? noTitle;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: .1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
          width: .8.sw,
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 25.w),
          decoration: BoxDecoration(
              color: context.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          // width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              40.verticalSpace,
              Text(
                title,
                maxLines: 7,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      onTapNo?.call();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
                      decoration: BoxDecoration(
                        color: context.scaffoldBackgroundColor,
                        border: Border.all(
                          color: context.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          noTitle ?? 'dialog.no'.tr(),
                          style: context.textTheme.titleSmall!
                              .copyWith(color: context.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onTapYes();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.sp, vertical: 5),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          yesTitle ?? 'dialog.yes'.tr(),
                          style: context.textTheme.titleSmall!
                              .copyWith(color: context.scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          )),
    );
  }
}
