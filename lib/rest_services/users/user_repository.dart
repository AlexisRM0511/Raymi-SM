import '/rest_services/users/user_model.dart';

abstract class UserRepository {

  Future<UserModel?> getUserById(String id);

  Future<UserModel?> createUser(UserModel user);

  Future<void> updateUser(UserModel user);

  Future<void> deleteUser(String id);

  Future<UserModel?> signIn(String email, String password);
}
