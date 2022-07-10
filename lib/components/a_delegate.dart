import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Flexible Persistent header
class AFlexiblePersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget Function(BuildContext context, double offset, bool overlapped)
      builder;
  final double minHeight;
  final double maxHeight;

  AFlexiblePersistentHeader({
    required this.builder,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);

    var overlaps = shrinkOffset >= (maxExtent - minExtent) - 20.0;

    return Container(
      constraints: BoxConstraints(minHeight: minExtent, maxHeight: maxExtent),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.canvasColor.withOpacity(0.1),
            ),
          ),
          ClipRect(
            clipBehavior: Clip.antiAlias,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              color: overlaps
                  ? theme.colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
              child: BackdropFilter(
                filter: overlaps
                    ? ImageFilter.blur(sigmaY: 10, sigmaX: 10)
                    : ImageFilter.blur(),
                child: builder(context, shrinkOffset, overlaps),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

/// Fixed Sized Persistent header
class AFixedPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final Widget? leading;
  final bool hasBackButton;
  final List<Widget>? actions;
  final List<Widget> Function(
      BuildContext context, bool overlapping, double progress)? actionsBuilder;
  final Color? bgColor;
  final double height = 80;

  AFixedPersistentHeader({
    required this.child,
    this.leading,
    this.hasBackButton = true,
    this.actions,
    this.actionsBuilder,
    this.bgColor,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    var progress = shrinkOffset / maxExtent;
    return Stack(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
              gradient: bgColor == null
                  ? LinearGradient(
                      colors: [
                        theme.canvasColor.withOpacity(0.5),
                        theme.canvasColor.withOpacity(0.1),
                      ],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                    )
                  : null,
              color: bgColor),
        ),
        ClipRect(
          clipBehavior: Clip.hardEdge,
          child: Container(
            height: height,
            color: progress >= 0.5
                ? theme.canvasColor.withOpacity(0.3)
                : Colors.transparent,
            child: BackdropFilter(
              filter: progress >= 0.05
                  ? ImageFilter.blur(sigmaY: 10, sigmaX: 10)
                  : ImageFilter.blur(),
              child: Material(
                elevation: 0.0,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (hasBackButton) ...[
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                      ],
                      if (leading != null)
                        Padding(
                          padding: EdgeInsets.only(
                              left: !hasBackButton ? 5.0 : 0.0,
                              right: 5.0,
                              bottom: 12.5),
                          child: leading!,
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: !hasBackButton ? 10.0 : 0.0, bottom: 20.0),
                          child: child,
                        ),
                      ),
                      if (actionsBuilder != null)
                        ...actionsBuilder!(context, overlapsContent, progress),
                      if (actions != null &&
                          actions!.isNotEmpty &&
                          actionsBuilder == null)
                        ...actions!
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
