// responsabilidade: Barra superior, logo e notificaçõesimport 'package:material_ui/material_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/widgets/brand_logo.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

//resp Barra superior

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({required this.isWide, super.key});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 62,
      color: TKSColors.navigationBackground,
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          if (!isWide)
            Builder(
              builder: (context) => IconButton(
                tooltip: l10n.textOpenMenu,
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu_rounded),
              ),
            )
          else
            const SizedBox(width: 44),
          const Spacer(),
          BrandLogo(),
          const Spacer(),
          IconButton(
            tooltip: l10n.textNotifications,
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.textNoNewNotifications)),
            ),
            icon: const Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.notifications_none_rounded, color: Colors.white70),
                Positioned(
                  right: -1,
                  top: 0,
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: TKSColors.notification,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
