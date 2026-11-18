import 'package:flutter_test/flutter_test.dart';
import 'package:seguro_app/core/validators/cpf_validator.dart';

void main() {
  group('CpfValidator.validate', () {
    test('accepts valid CPF with or without mask', () {
      expect(CpfValidator.validate('529.982.247-25'), isNull);
      expect(CpfValidator.validate('52998224725'), isNull);
    });

    test('rejects empty value', () {
      expect(CpfValidator.validate(''), 'Digite seu CPF.');
    });
    test('rejects CPF with incorrect number of digits', () {
      expect(CpfValidator.validate('123456789'), isNotNull);
    });

    test('rejects sequence of repeated digits', () {
      expect(CpfValidator.validate('111.111.111-11'), isNotNull);
    });

    test('rejects CPF with invalid check digits', () {
      expect(CpfValidator.validate('529.982.247-24'), isNotNull);
    });
  });
}