import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.listenableValue,
    this.items,
    this.onChanged,
    this.label,
    this.hint,
    this.enabled = true,
    this.isExpanded = true,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.selectedItemBuilder,
  });

  // final T? value;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final ValueNotifier<T?> listenableValue;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? label;
  final String? hint;
  final bool? enabled;
  final bool? isExpanded;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Stack(
          children: [
            Container(
              height: height ?? 54.h,
              decoration: BoxDecoration(
                color: backgroundColor ?? context.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color:
                      (textColor ?? context.theme.hintColor).withOpacity(0.2),
                ),
              ),
              child: ValueListenableBuilder(
                valueListenable: listenableValue,
                builder: (context, value, _) {
                  print(value);
                  return Center(
                    widthFactor: 1,
                    child: DropdownButton<T?>(
                      value: value,
                      selectedItemBuilder: selectedItemBuilder,
                      dropdownColor: context.theme.colorScheme.surface,
                      hint: Text(
                        hint ?? 'form.select'.tr(),
                        style: context.textTheme.labelSmall?.copyWith(
                            color:
                                enabled! ? null : context.theme.highlightColor),
                      ),

                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamilyFallback: [
                          'Roboto',
                          'NRT',
                          'Tajawal',
                          'SF Pro Text',
                          'Rudaw'
                        ],
                        color: textColor ?? context.theme.colorScheme.onSurface,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      // focusColor: AppColors.surfaceContainerLow(context),
                      underline: const SizedBox(),
                      items: items,

                      onChanged: enabled!
                          ? (onChanged ??
                              (value) {
                                listenableValue.value = value;
                              })
                          : null,
                      isExpanded: isExpanded!,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      padding: EdgeInsetsDirectional.only(
                        start: 8.sp,
                      ),
                      isDense: true,
                      // dropdownColor: AppColors.surfaceContainerLow(context),
                    ),
                  );
                },
              ),
            ),
            if (label != null) ...[
              PositionedDirectional(
                top: -9,
                start: 10,
                child: Container(
                  clipBehavior: Clip.none,
                  color: context.theme.colorScheme.surface,
                  child: Text(
                    ' ${label!} ',
                    style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.transparent, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              15.verticalSpace,
            ],
          ],
        ),
        if (label != null) ...[
          PositionedDirectional(
            top: -9,
            start: 10,
            child: Text(
              ' ${label!} ',
              style: context.textTheme.bodyMedium?.copyWith(
                  color: context.theme.hintColor, fontWeight: FontWeight.bold),
            ),
          ),
          15.verticalSpace,
        ],
      ],
    );
  }
}
