import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/core/theme/tks_gradients.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

class HomeWelcomeBanner extends StatelessWidget {
  const HomeWelcomeBanner({required this.userName, super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 76,
      width: double.infinity,
      decoration: BoxDecoration(gradient: TKSGradients.brand),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/customer.png'),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.textWelcomeUser,
                style: TextStyle(fontSize: 11, color: TKSColors.welcomeText),
              ),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 17,
                  color: TKSColors.welcomeText,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
