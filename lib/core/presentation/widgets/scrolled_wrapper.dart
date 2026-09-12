import 'package:flutter/material.dart';

class ScrolledWrapper extends StatelessWidget {
  const ScrolledWrapper({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.only(
      top: 24.0,
      left: 24.0,
      right: 24.0,
      bottom: MediaQuery.viewInsetsOf(context).bottom,
    );
    final contentPadding = padding ?? defaultPadding;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: contentPadding,
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  constraints.maxHeight -
                  contentPadding.top +
                  contentPadding.bottom,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
