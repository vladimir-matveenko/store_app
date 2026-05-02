import 'package:flutter/material.dart';

class ScrollUpButton extends StatelessWidget {
  const ScrollUpButton({
    super.key,
    required this.showScrollUp,
    required this.scrollController,
  });

  final ValueNotifier<bool> showScrollUp;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<bool>(
      valueListenable: showScrollUp,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.7),
                end: Offset.zero,
              ).animate(curved),
              child: FadeTransition(opacity: curved, child: child),
            );
          },
          child: value
              ? Padding(
                  key: const ValueKey('scrollUpButton'),
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.outlined(
                        padding: const EdgeInsets.all(8.0),
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(const CircleBorder()),
                          backgroundColor: WidgetStateProperty.all(
                            theme.unselectedWidgetColor.withValues(alpha: 0.8),
                          ),
                        ),
                        onPressed: () {
                          scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_upward_outlined,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(key: ValueKey('empty')),
        );
      },
    );
  }
}
