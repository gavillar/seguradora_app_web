import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/core/theme/tks_gradients.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: TKSColors.background),

            Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                heightFactor: 0.46,
                widthFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: TKSGradients.brand),
                ),
              ),
            ),
            child,
          ],
        );
      },
    );
  }
}
