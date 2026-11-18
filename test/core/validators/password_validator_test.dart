import 'package:flutter_test/flutter_test.dart';
import 'package:seguro_app/core/validators/password_validator.dart';

void main() {
  group('PasswordValidator.validate', () {
    test('accepts a password that meets all requirements', () {
      expect(PasswordValidator.validate('Secure@123'), isNull);
    });

    test('rejects a null password', () {
      expect(PasswordValidator.validate(null), isNotNull);
    });

    test('rejects an empty password', () {
      expect(PasswordValidator.validate(''), isNotNull);
    });

    test('rejects a password shorter than eight characters', () {
      expect(PasswordValidator.validate('Ab1!'), isNotNull);
    });

    test('rejects a password without an uppercase letter', () {
      expect(PasswordValidator.validate('secure@123'), isNotNull);
    });

    test('rejects a password without a lowercase letter', () {
      expect(PasswordValidator.validate('SECURE@123'), isNotNull);
    });

    test('rejects a password without a number', () {
      expect(PasswordValidator.validate('Secure@abc'), isNotNull);
    });

    test('rejects a password without a special character', () {
      expect(PasswordValidator.validate('Secure123'), isNotNull);
    });
  });
}
