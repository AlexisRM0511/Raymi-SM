import '/rest_services/users/user_model.dart';

abstract class UserRepository {

  Future<UserModel?> getUserById(String id);

  Future<UserModel?> createUser(UserModel user);

  Future<String?> updateUser(UserModel user);

  Future<String?> deleteUser(String id);
}
