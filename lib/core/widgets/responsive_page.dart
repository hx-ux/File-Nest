import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    super.key,
    required this.child,
    this.maxWidth = 920,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth < 600 ? 16.0 : 24.0;
        final effectivePadding = padding ??
            EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 16,
            );

        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
                minHeight: constraints.maxHeight,
                maxHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: effectivePadding,
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}
