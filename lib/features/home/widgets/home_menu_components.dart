import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

class HomeMenuPlaceholder extends StatelessWidget {
  const HomeMenuPlaceholder({
    super.key,
    required this.title,
    required this.onBack,
  });

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.construction_rounded,
              color: TKSColors.mint,
              size: 44,
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.textPlaceholderDescription,
              textAlign: TextAlign.center,
              style: TextStyle(color: TKSColors.muted),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onBack, child: Text(l10n.textBackToHome)),
          ],
        ),
      ),
    );
  }
}
