class CpfValidator {
  CpfValidator._();

  static String? validate(String? value) {
    final cpf = (value ?? '').replaceAll(RegExp(r'\D'), '');

    if (cpf.isEmpty) {
      return 'Digite seu CPF.';
    }

    if (cpf.length != 11) {
      return 'O CPF deve conter 11 números.';
    }

    if (RegExp(r'^(\d)\1{10}$').hasMatch(cpf)) {
      return 'Digite um CPF válido.';
    }

    final firstCheckDigit = _calculateCheckDigit(cpf, 9);
    if (int.parse(cpf[9]) != firstCheckDigit) {
      return 'Digite um CPF válido.';
    }

    final secondCheckDigit = _calculateCheckDigit(cpf, 10);
    if (int.parse(cpf[10]) != secondCheckDigit) {
      return 'Digite um CPF válido.';
    }

    return null;
  }
  static int _calculateCheckDigit(String cpf, int length) {
    var sum = 0;

    for (var index = 0; index < length; index++) {
      final digit = int.parse(cpf[index]);
      final weight = length + 1 - index;
      sum += digit * weight;
    }

    final remainder = sum % 11;
    return remainder < 2 ? 0 : 11 - remainder;
  }
}
