import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';

abstract final class TKSInputDecoration {
  static InputDecoration rounded({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 12, color: TKSColors.inputHint),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      isDense: true,
      errorStyle: const TextStyle(fontSize: 9, height: 0.8),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: TKSColors.inputBorder, width: 1.3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: TKSColors.inputFocusedBorder,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: TKSColors.inputErrorBorder,
          width: 1.3,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: TKSColors.inputErrorBorder,
          width: 1.5,
        ),
      ),
    );
  }
}
