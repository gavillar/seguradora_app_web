class PasswordValidator {
  PasswordValidator._();

  static String? validate(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Digite sua senha.';
    }

    if (password.length < 8) {
      return 'A senha deve conter pelo menos 8 caracteres.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'A senha deve conter uma letra maiúscula.';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'A senha deve conter uma letra minúscula.';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'A senha deve conter pelo menos um número.';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\];~`]').hasMatch(password)) {
      return 'A senha deve conter um caractere especial.';
    }

    return null;
  }
}
