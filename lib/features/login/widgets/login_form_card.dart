import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:seguro_app/core/input_formatters/cpf_input_formatter.dart';
import 'package:seguro_app/core/theme/tks_colors.dart';
import 'package:seguro_app/core/theme/tks_gradients.dart';
import 'package:seguro_app/core/theme/tks_input_decoration.dart';
import 'package:seguro_app/core/validators/cpf_validator.dart';
import 'package:seguro_app/core/validators/password_validator.dart';
import 'package:seguro_app/features/login/widgets/login_tab.dart';
import 'package:seguro_app/l10n/app_localizations.dart';

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
        title: Text('Esqueceu a senha?'),
        content: Text(
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
    final l10n = AppLocalizations.of(context)!;
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
                  label: l10n.textLogin,
                  selected: !widget.registerMode,
                  onTap: () => widget.onModeChanged(false),
                ),
                const SizedBox(width: 14),
                LoginTab(
                  label: l10n.textRegister,
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
              validator: CpfValidator.validate,
              decoration: TKSInputDecoration.rounded(hint: l10n.textCpf),
            ),
            const SizedBox(height: 9),
            TextFormField(
              controller: _passwordController,
              obscureText: _hidePassword,
              textAlign: TextAlign.center,
              validator: PasswordValidator.validate,
              decoration: TKSInputDecoration.rounded(hint: l10n.textPassword)
                  .copyWith(
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
                      tooltip: _hidePassword
                          ? l10n.textShowPassword
                          : l10n.textHidePassword,
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
                Text(
                  l10n.textRememberMe,
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
                  child: Text(
                    l10n.texFforgotPasswordTitle,
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
                        color: TKSColors.mintShadow,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.registerMode
                        ? Icons.person_add_alt_1
                        : Icons.arrow_forward_rounded,
                    color: TKSColors.white,
                    size: 27,
                  ),
                ),
              ),
            ),
            if (widget.registerMode) ...[
              const SizedBox(height: 10),
              Text(
                l10n.textDemonstrationRegistration,
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
