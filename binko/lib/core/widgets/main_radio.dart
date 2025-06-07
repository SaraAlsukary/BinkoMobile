import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final int? groupValue;
  final void Function(int) onChanged;
  final double size;
  final bool isActive;
  final String? text;
  final String? price;
  final bool isChip;

  const CustomRadio({
    super.key,
    required this.value,
    this.isActive = true,
    required this.groupValue,
    this.size = 10,
    required this.onChanged,
    this.text,
    this.price,
    this.isChip = false,
  }) : assert((isChip != true && text != null) || isChip != false);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isActive,
      child: GestureDetector(
        onTap: () => widget.onChanged(widget.value),
        child: widget.isChip
            ? Chip(
                label: Text.rich(
                  TextSpan(
                    text: widget.text,
                    style: context.textTheme.labelMedium!.copyWith(
                        color: !widget.isActive
                            ? context.theme.highlightColor
                            : widget.value == widget.groupValue
                                ? context.theme.colorScheme.onPrimary
                                : null),
                  ),
                  style: context.textTheme.labelMedium!.copyWith(
                      color: !widget.isActive
                          ? context.theme.highlightColor
                          : widget.value == widget.groupValue
                              ? context.theme.colorScheme.onPrimary
                              : null),
                ),
                side: BorderSide(
                    color: !widget.isActive
                        ? context.theme.highlightColor.withOpacity(.1)
                        : widget.value == widget.groupValue
                            ? context.theme.colorScheme.primary
                            : context.theme.hintColor),
                backgroundColor: !widget.isActive
                    ? context.theme.highlightColor.withOpacity(.1)
                    : widget.value == widget.groupValue
                        ? context.theme.colorScheme.primary
                        : null)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: context.theme.highlightColor),
                        shape: BoxShape.circle,
                        color: context.scaffoldBackgroundColor),
                    child: Center(
                      child: Icon(
                        Icons.circle,
                        size: widget.size,
                        color: (widget.value == widget.groupValue)
                            ? context.primaryColor
                            : context.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                  if (widget.price != null) ...[
                    Text(
                      'currency.symbol'.tr() + (widget.price ?? ''),
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: context.theme.colorScheme.error),
                    ),
                    5.horizontalSpace,
                  ],
                  if (widget.text != null) ...[
                    Text(
                      widget.text!,
                      style: context.textTheme.labelMedium,
                    ),
                    5.horizontalSpace,
                  ],
                ],
              ),
      ),
    );
  }
}
