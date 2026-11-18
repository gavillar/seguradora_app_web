import 'package:seguro_app/core/models/user_model.dart';

class UserRepository {
  static const _users = [
    UserModel(cpf: '52998224725', name: 'João da Silva', password: 'Tokyomarine10#'),
  ];

  UserModel? findByCpf(String cpf) {
    final normalizedCpf = cpf.replaceAll(RegExp(r'\D'), '');

    for (final user in _users) {
      if (user.cpf == normalizedCpf) {
        return user;
      }
    }

    return null;
  }

  UserModel? authenticate({required String cpf, required String password}) {
    final user = findByCpf(cpf);

    if (user == null || user.password != password) {
      return null;
    }

    return user;
  }
}
