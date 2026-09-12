import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDialog {
  static Future<bool> show(
    BuildContext context, {
    String? title,
    required String text,
    String? cancelText,
    required String okText,
  }) async {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        constraints: const BoxConstraints(maxWidth: 400.0),
        child: Padding(
          padding: const .all(16.0),
          child: Column(
            mainAxisSize: .min,
            spacing: 16.0,
            children: [
              if (title != null) Text(title, style: textTheme.titleMedium),
              Text(text, style: textTheme.bodyMedium),
              Row(
                mainAxisAlignment: .spaceBetween,
                mainAxisSize: .min,
                spacing: 16.0,
                children: [
                  if (cancelText != null)
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () => context.pop(false),
                        child: Text(
                          cancelText,
                          style: textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                      ),
                      onPressed: () => context.pop(true),
                      child: Text(
                        okText,
                        style: textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    return result ?? false;
  }

  static Future empty(
    BuildContext context, {
    required Widget content,
    VoidCallback? onClose,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(child: content),
    ).then((_) {
      onClose?.call();
    });
  }
}
