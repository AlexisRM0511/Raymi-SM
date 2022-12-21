import '/rest_services/users/user_model.dart';
import '/rest_services/users/user_repository.dart';

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  Future<List<UserModel>?> getUsers() async => _userRepository.getUsers();

  Future<UserModel?> getUserById(String id) async =>
      _userRepository.getUserById(id);

  Future<UserModel?> createUser(UserModel user) async =>
      _userRepository.createUser(user);

  Future<String?> updateUser(UserModel user) async =>
      _userRepository.updateUser(user);

  Future<String?> deleteUser(String id) async => _userRepository.deleteUser(id);

  Future<UserModel?> getUserByDni(String dni) async =>
      _userRepository.getUserByDni(dni);

  Future<UserModel?> getUserByEmail(String email) async =>
      _userRepository.getUserByEmail(email);

  Future<UserModel?> getUserByIdFirebase(String idFirebase) async =>
      _userRepository.getUserByIdFirebase(idFirebase);
}
