import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/input_formatters/cpf_input_formatter.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/core/theme/tks_gradients.dart';
import 'package:seguro_app/core/theme/tks_input_decoration.dart';
import 'package:seguro_app/features/login/widgets/login_tab.dart';

typedef LoginFormSubmit = void Function(
  String cpf,
  String password,
  bool registerMode,
);

class LoginFormCard extends StatefulWidget {
  const LoginFormCard({
    required this.registerMode,
    required this.onModeChanged,
    required this.onSubmit,
    this.onForgotPassword,
    super.key,
  });

  final bool registerMode;
  final ValueChanged<bool> onModeChanged;
  final LoginFormSubmit onSubmit;
  final VoidCallback? onForgotPassword;

  @override
  State<LoginFormCard> createState() => _LoginFormCardState();
}

class _LoginFormCardState extends State<LoginFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = true;
  bool _hidePassword = true;

  @override
  void dispose() {
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(
      _cpfController.text.trim(),
      _passwordController.text,
      widget.registerMode,
    );
  }

  void _openForgotPassword() {
    final callback = widget.onForgotPassword;
    if (callback != null) {
      callback();
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: TKSColors.panel,
        title: const Text('Esqueceu a senha?'),
        content: const Text(
          'A recuperação de senha será conectada à API ou ao Firebase do projeto.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 17, 20, 18),
      decoration: BoxDecoration(
        color: TKSColors.panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                LoginTab(
                  label: 'Entrar',
                  selected: !widget.registerMode,
                  onTap: () => widget.onModeChanged(false),
                ),
                const SizedBox(width: 14),
                LoginTab(
                  label: 'Cadastrar',
                  selected: widget.registerMode,
                  onTap: () => widget.onModeChanged(true),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _cpfController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              validator: (value) {
                final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
                if (digits.length != 11) {
                  return 'Digite um CPF válido.';
                }
                return null;
              },
              decoration: TKSInputDecoration.rounded(hint: 'CPF'),
            ),
            const SizedBox(height: 9),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              textAlign: TextAlign.center,
              validator: (value) {
                if ((value ?? '').length < 4) {
                  return 'Senha inválida';
                }
                return null;
              },
              decoration: TKSInputDecoration.rounded(hint: 'Senha').copyWith(
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _hidePassword = !_hidePassword),
                  icon: Icon(
                    _hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                  ),
                  color: TKSColors.muted,
                  tooltip: _hidePassword ? 'Mostrar senha' : 'Ocultar senha',
                ),
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: _rememberMe,
                    activeColor: TKSColors.mint,
                    checkColor: TKSColors.background,
                    onChanged: (value) {
                      setState(() => _rememberMe = value ?? false);
                    },
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Lembrar sempre',
                  style: TextStyle(fontSize: 10, color: Colors.white70),
                ),
                const Spacer(),
                TextButton(
                  onPressed: _openForgotPassword,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Esqueceu a senha?',
                    style: TextStyle(fontSize: 10, color: TKSColors.mint),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Semantics(
              button: true,
              label: widget.registerMode ? 'Criar conta' : 'Entrar',
              child: InkWell(
                onTap: _submit,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: TKSGradients.brand,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x5533C3A4),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.registerMode
                        ? Icons.person_add_alt_1
                        : Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
            if (widget.registerMode) ...[
              const SizedBox(height: 10),
              const Text(
                'Cadastro demonstrativo. A integração com autenticação pode ser conectada aqui.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TKSColors.muted,
                  fontSize: 10,
                  height: 1.35,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
