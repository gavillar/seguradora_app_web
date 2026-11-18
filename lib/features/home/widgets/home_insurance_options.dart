import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/enums/home_product_enum.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';

class HomeInsuranceOptions extends StatelessWidget {
  const HomeInsuranceOptions({super.key, required this.onOpenProduct});

  final ValueChanged<HomeProduct> onOpenProduct;

  static const _options = <_InsuranceData>[
    _InsuranceData(
      product: HomeProduct.automobile,
      'Automóvel',
      Icons.directions_car_filled_rounded,
      TKSColors.automobile,
    ),
    _InsuranceData(
      product: HomeProduct.residence,
      'Residência',
      Icons.home_work_rounded,
      TKSColors.residence,
    ),
    _InsuranceData(
      product: HomeProduct.life,
      'Vida',
      Icons.favorite_rounded,
      TKSColors.life,
    ),
    _InsuranceData(
      product: HomeProduct.personalAccident,
      'Acidentes\nPessoais',
      Icons.health_and_safety_rounded,
      TKSColors.personalAccident,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        final itemWidth = compact
            ? (constraints.maxWidth - 30) / 4
            : constraints.maxWidth < 760
            ? (constraints.maxWidth - 30) / 4
            : 112.0;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final option in _options)
              SizedBox(
                width: itemWidth,
                child: _InsuranceCard(
                  option: option,
                  onTap: () => onOpenProduct(option.product),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _InsuranceData {
  const _InsuranceData(
    this.label,
    this.icon,
    this.color, {
    required this.product,
  });

  final String label;
  final IconData icon;
  final Color color;
  final HomeProduct product;
}

class _InsuranceCard extends StatelessWidget {
  const _InsuranceCard({required this.option, required this.onTap});

  final _InsuranceData option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: TKSColors.panel,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 94,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: TKSColors.white.withValues(alpha: 0.07)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon, size: 26, color: option.color),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  option.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.1,
                    color: TKSColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
