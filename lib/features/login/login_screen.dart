import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/features/home/home_screen.dart';
import 'package:seguro_app/core/widgets/brand_logo.dart';
import 'package:seguro_app/features/login/data/user_repository.dart';
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
  final _userRepository = UserRepository();
  @override
  void initState() {
    super.initState();
    _registerMode = widget.registerMode;
  }

  void _handleLoginSubmit(String cpf, String password, bool registerMode) {
    if (registerMode) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cadastro demonstrativo.')));
      return;
    }

    final user = _userRepository.authenticate(cpf: cpf, password: password);

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('CPF ou senha incorretos.')));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen(userName: user.name)),
    );
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
                            onSubmit: _handleLoginSubmit,
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
