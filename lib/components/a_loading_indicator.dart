import 'package:financial_terms/config/a_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'a_spinning_lines.dart';

class ALoadingIndicator extends StatelessWidget {
  final String? label;
  final double size;
  final int lineCount;
  final double lineWidth;
  final Color? color;
  final Duration? duration;

  const ALoadingIndicator({
    Key? key,
    this.label,
    this.size = 50.0,
    this.lineCount = 1,
    this.lineWidth = 4.0,
    this.color,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: label != null && label!.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _spinningLines(theme),
                SizedBox(
                  height: FinancialTermsAppTheme.paddingMedium,
                ),
                Text(
                  "$label",
                  style: GoogleFonts.arsenal(
                    color: theme.textTheme.caption?.color,
                  ),
                  textScaleFactor: size / 55.0,
                )
              ],
            )
          : _spinningLines(theme),
    );
  }

  /// Spinner
  Widget _spinningLines(ThemeData theme) => ASpinningLines(
        color: color ?? theme.colorScheme.primary,
        itemCount: lineCount,
        lineWidth: lineWidth,
        size: size,
        duration: duration ?? FinancialTermsAppTheme.durationFast * 6,
      );
}
