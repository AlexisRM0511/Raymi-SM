import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_repository.dart';

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  Future<UserModel?> createUser(UserModel user) async =>
      _userRepository.createUser(user);

  Future<UserModel?> readUser(String id) async => _userRepository.readUser(id);

  Future<bool> updateUser(UserModel user) async =>
      _userRepository.updateUser(user);

  Future<bool> deleteUser(String id) async => _userRepository.deleteUser(id);

  Future<UserModel?> signIn(String email, String password) async =>
      _userRepository.signIn(email, password);

  Future<UserModel?> getCurrentUser() async => _userRepository.getCurrentUser();
}
