import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/l10n/app_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: kIsWeb
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          l10n.textWelcome,
          textAlign: kIsWeb ? TextAlign.center : TextAlign.start,
          style: const TextStyle(
            color: TKSColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 285,
          child: Text(
            l10n.textWelcomeMessage,
            textAlign: kIsWeb ? TextAlign.center : TextAlign.start,
            style: const TextStyle(
              color: TKSColors.white,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}
