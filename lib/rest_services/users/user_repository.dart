import '/rest_services/users/user_model.dart';

abstract class UserRepository {

  Future<UserModel?> createUser(UserModel user);

  Future<UserModel?> readUser(String id);

  Future<bool> updateUser(UserModel user);

  Future<bool> deleteUser(String id);

  Future<UserModel?> signIn(String email, String password);

  Future<UserModel?> getCurrentUser();
}
