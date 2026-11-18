class UserModel {
  const UserModel({
    required this.cpf,
    required this.name,
    required this.password,
  });

  final String cpf;
  final String name;
  final String password;
}