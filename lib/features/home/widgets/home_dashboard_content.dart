import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/enums/home_product_enum.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/features/home/widgets/home_insurance_options.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

class HomeDashboardContent extends StatelessWidget {
  const HomeDashboardContent({
    super.key,
    required this.familyMembers,
    required this.onAddFamilyMember,
    required this.onOpenProduct,
  });

  final List<String> familyMembers;
  final VoidCallback onAddFamilyMember;
  final ValueChanged<HomeProduct> onOpenProduct;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktopContent = constraints.maxWidth >= 760;
        final maxContentWidth = constraints.maxWidth > 1320
            ? 1260.0
            : double.infinity;
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktopContent ? 30 : 16,
            vertical: 20,
          ),
          child: Center(
            child: SizedBox(
              width: maxContentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.textQuoteAndHire,
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 13),
                  HomeInsuranceOptions(onOpenProduct: onOpenProduct),
                  const SizedBox(height: 22),
                  if (isDesktopContent)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _HomeSection(
                            title: l10n.textMyFamily,
                            child: _FamilyCard(
                              members: familyMembers,
                              onAdd: onAddFamilyMember,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _HomeSection(
                            title: l10n.textContracted,
                            child: _ContractedCard(),
                          ),
                        ),
                      ],
                    )
                  else ...[
                    _HomeSection(
                      title: l10n.textMyFamily,
                      child: _FamilyCard(
                        members: familyMembers,
                        onAdd: onAddFamilyMember,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _HomeSection(
                      title: l10n.textContracted,
                      child: _ContractedCard(),
                    ),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomeSection extends StatelessWidget {
  const _HomeSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}

class _ContractedCard extends StatelessWidget {
  const _ContractedCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _EmptyPanel(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            size: 38,
            color: TKSColors.white,
          ),
          SizedBox(height: 11),
          Text(
            l10n.textNoContractedInsurance,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              height: 1.35,
              color: TKSColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilyCard extends StatelessWidget {
  const _FamilyCard({required this.members, required this.onAdd});

  final List<String> members;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _EmptyPanel(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onAdd,
            tooltip: l10n.textAddFamilyMemberTooltip,
            icon: const Icon(Icons.add_circle_outline_rounded, size: 38),
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.textAddFamilyDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, height: 1.35, color: Colors.white70),
          ),
          const SizedBox(height: 5),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.person_add_alt_1, size: 15),
            label: Text(l10n.textAddMember, style: TextStyle(fontSize: 11)),
            style: TextButton.styleFrom(
              foregroundColor: TKSColors.mint,
              visualDensity: VisualDensity.compact,
            ),
          ),
          if (members.isNotEmpty) ...[
            const Divider(height: 12, color: TKSColors.divider),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final member in members)
                  Chip(
                    avatar: const Icon(Icons.person_outline, size: 15),
                    label: Text(member, style: const TextStyle(fontSize: 11)),
                    visualDensity: VisualDensity.compact,
                    backgroundColor: TKSColors.familyChip,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 164),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: TKSColors.panel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: TKSColors.white.withValues(alpha: 0.045)),
      ),
      child: child,
    );
  }
}
