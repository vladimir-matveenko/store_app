import 'package:material_ui/material_ui.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(color: theme.unselectedWidgetColor);
  }
}
