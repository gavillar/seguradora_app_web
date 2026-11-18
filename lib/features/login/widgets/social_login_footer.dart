import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/core/widgets/brand_logo.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

class SocialLoginFooter extends StatelessWidget {
  const SocialLoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandLogo(),
        SizedBox(height: 9),
        Text(
          l10n.textAccessOnSocialMedias,
          style: TextStyle(fontSize: 10, color: TKSColors.white),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/social/google.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                TKSColors.white,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 18),
            SvgPicture.asset(
              'assets/icons/social/facebook.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                TKSColors.white,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 18),
            SvgPicture.asset(
              'assets/icons/social/twitter.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                TKSColors.white,
                BlendMode.srcIn,
              ),
            ),
            // _SocialIcon(label: Assets.icons.social.facebook),
            // SizedBox(width: 18),
            // _SocialIcon(label: Assets.icons.social.twitter),
          ],
        ),
      ],
    );
  }
}
