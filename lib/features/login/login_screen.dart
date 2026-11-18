import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/features/home/home_screen.dart';
import 'package:seguro_app/core/widgets/brand_logo.dart';
import 'package:seguro_app/features/login/widgets/login_background.dart';
import 'package:seguro_app/features/login/widgets/login_form_card.dart';
import 'package:seguro_app/features/login/widgets/login_header.dart';
import 'package:seguro_app/features/login/widgets/social_login_footer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginScreen extends StatefulWidget {
  final bool registerMode;

  const LoginScreen({super.key, this.registerMode = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool _registerMode;

  @override
  void initState() {
    super.initState();
    _registerMode = widget.registerMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: ConstrainedBox(
                    // Limita a largura do conjunto no Web.
                    // No mobile, mantém a largura disponível atual.
                    constraints: BoxConstraints(
                      maxWidth: kIsWeb ? 460 : constraints.maxWidth,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: kIsWeb
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Center(child: BrandLogo()),
                          const SizedBox(height: 25),
                          const LoginHeader(),
                          const SizedBox(height: 40),
                          LoginFormCard(
                            registerMode: _registerMode,
                            onModeChanged: (value) {
                              setState(() => _registerMode = value);
                            },
                            onSubmit: (cpf, password, isRegistering) {
                              if (isRegistering) return;

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          const SocialLoginFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
