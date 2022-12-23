import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_repository.dart';

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  Future<UserModel?> signIn(String email, String password) async =>
    _userRepository.signIn(email, password);


  Future<UserModel?> getUserById(String id) async =>
      _userRepository.getUserById(id);

  Future<UserModel?> createUser(UserModel user) async =>
      _userRepository.createUser(user);

  Future<void> updateUser(UserModel user) async =>
      _userRepository.updateUser(user);

  Future<void> deleteUser(String id) async => _userRepository.deleteUser(id);
}
