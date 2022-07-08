import 'package:financial_terms/config/a_theme.dart';
import 'package:financial_terms/utils/extension_functions.dart';
import 'package:flutter/material.dart';

class ACard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  final Color? shadowColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double elevation;
  final BoxBorder? border;
  final VoidCallback? onClick;
  final void Function(bool value)? onHover;
  final void Function(TapUpDetails details)? onTapUp;
  final void Function(TapDownDetails details)? onTapDown;

  const ACard({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.color,
    this.gradient,
    this.shadowColor,
    this.margin,
    this.padding,
    this.elevation = 0.0,
    this.borderRadius,
    this.border,
    this.onClick,
    this.onHover,
    this.onTapUp,
    this.onTapDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          type: MaterialType.card,
          borderRadius: borderRadius ?? BorderRadius.circular(FinancialTermsAppTheme.radius),
          elevation: theme.light ? elevation : 0.75,
          shadowColor: shadowColor ??
              (theme.light
                  ? theme.dividerColor.withOpacity(0.30)
                  : theme.dividerColor.withOpacity(0.2)),
          // color: color,
          child: InkWell(
            onTap: onClick,
            onHover: onHover,
            onTapUp: onTapUp,
            onTapDown: onTapDown,
            hoverColor: Colors.transparent,
            borderRadius: borderRadius ?? BorderRadius.circular(FinancialTermsAppTheme.radius),
            child: Ink(
              padding: padding ?? EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius:
                    borderRadius ?? BorderRadius.circular(FinancialTermsAppTheme.radius),
                color: color,
                gradient: gradient,
                border: border,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
