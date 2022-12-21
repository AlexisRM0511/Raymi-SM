import '/rest_services/users/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>?> getUsers();

  Future<UserModel?> getUserById(String id);

  Future<UserModel?> createUser(UserModel user);

  Future<String?> updateUser(UserModel user);

  Future<String?> deleteUser(String id);

  Future<UserModel?> getUserByDni(String dni);

  Future<UserModel?> getUserByEmail(String email);

  Future<UserModel?> getUserByIdFirebase(String idFirebase);
}
