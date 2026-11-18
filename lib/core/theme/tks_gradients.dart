import 'package:material_ui/material_ui.dart';

import 'tks_colors.dart';

abstract final class TKSGradients {
  static LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [TKSColors.gradientStart, TKSColors.mint, TKSColors.gradientEnd],
    stops: [0, 0.55, 1],
  );
}
