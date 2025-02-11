import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/context_extensions.dart';
import '../extensions/widget_extensions.dart';
import '../services/shared_preferences_service.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color checkedIconColor;
  final Color? checkedFillColor;
  final IconData checkedIcon;
  final Color uncheckedIconColor;
  final Color uncheckedFillColor;
  final double? borderWidth;
  final IconData uncheckedIcon;
  final String? label;
  final String? price;
  final double? checkBoxSize;
  final bool shouldShowBorder;
  final Color? borderColor;
  final double? borderRadius;
  final double? splashRadius;
  final Color? splashColor;
  final String? tooltip;
  final MouseCursor? mouseCursors;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    this.checkedIconColor = Colors.white,
    this.checkedFillColor,
    this.checkedIcon = Icons.check,
    this.uncheckedIconColor = Colors.white,
    this.uncheckedFillColor = Colors.white,
    this.borderWidth,
    this.uncheckedIcon = Icons.close,
    this.label,
    this.price,
    this.checkBoxSize,
    this.shouldShowBorder = false,
    this.borderColor,
    this.borderRadius,
    this.splashRadius,
    this.splashColor,
    this.tooltip,
    this.mouseCursors,
  });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool _checked;
  late CheckStatus _status;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  void _init() {
    _checked = widget.value;
    if (_checked) {
      _status = CheckStatus.checked;
    } else {
      _status = CheckStatus.unchecked;
    }
  }

  Widget _buildIcon() {
    late Color fillColor;
    late Color iconColor;
    late IconData? iconData;

    switch (_status) {
      case CheckStatus.checked:
        fillColor = widget.checkedFillColor ?? context.primaryColor;
        iconColor = widget.checkedIconColor;
        iconData = widget.checkedIcon;
        break;
      case CheckStatus.unchecked:
        fillColor = widget.uncheckedFillColor;
        iconColor = widget.uncheckedIconColor;
        iconData = null;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: Durations.medium1,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius:
                BorderRadius.all(Radius.circular(widget.borderRadius ?? 6)),
            border: Border.all(
              color: widget.shouldShowBorder
                  ? (widget.borderColor ??
                      context.primaryColor.withOpacity(0.6))
                  : (!widget.value
                      ? (widget.borderColor ??
                          context.primaryColor.withOpacity(0.6))
                      : Colors.transparent),
              width: widget.shouldShowBorder ? widget.borderWidth ?? 2.0 : 1.0,
            ),
          ),
          child: Icon(
            iconData,
            key: ValueKey(widget.value),
            color: iconColor,
            size: widget.checkBoxSize ?? 18,
          )
              .animate(
                key: ValueKey(widget.value),
              )
              .scale(duration: Durations.medium1),
        ),
        if (widget.price != null) ...[
          5.horizontalSpace,
          Text(
            '${SharedPreferencesService.getCurrencySymbol()} ${widget.price!}',
            style: context.textTheme.bodyMedium!
                .copyWith(color: context.theme.colorScheme.error),
          ),
        ],
        if (widget.label != null) ...[
          5.horizontalSpace,
          Text(
            widget.label!,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildIcon().onTap(() => widget.onChanged.call(!widget.value));
  }
}

enum CheckStatus {
  checked,
  unchecked,
}
