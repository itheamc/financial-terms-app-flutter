import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/a_theme.dart';

class AButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final TextStyle? labelStyle;
  final VoidCallback? onPressed;
  final double elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AButton({
    Key? key,
    this.label,
    this.child,
    this.labelStyle,
    this.onPressed,
    this.elevation = 20.0,
    this.borderRadius,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: theme.buttonTheme.colorScheme?.primary,
        borderRadius: borderRadius ??
            BorderRadius.circular(FinancialTermsAppTheme.radiusXLarge),
        elevation: elevation,
        shadowColor: theme.dividerColor.withOpacity(0.10),
        child: InkWell(
          onTap: onPressed,
          borderRadius: borderRadius ??
              BorderRadius.circular(FinancialTermsAppTheme.radiusXLarge),
          child: Ink(
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: FinancialTermsAppTheme.paddingXXXLarge,
                  vertical: FinancialTermsAppTheme.paddingSmall,
                ),
            child: child ??
                Text(
                  "$label",
                  style: labelStyle ??
                      GoogleFonts.arsenal(
                        fontSize: 16.0,
                      ),
                ),
          ),
        ),
      ),
    );
  }
}
