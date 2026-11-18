import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: TKSColors.white, width: 1.5),
          ),
          child: const Icon(
            Icons.waves_rounded,
            size: 21,
            color: TKSColors.white,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.textEnsuranceName,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                letterSpacing: 1,
                height: 1.1,
              ),
            ),
            Text(
              l10n.textEnsurance,
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
