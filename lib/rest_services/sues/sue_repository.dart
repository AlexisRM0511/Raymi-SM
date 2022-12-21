import '/rest_services/sues/sue_model.dart';

abstract class SueRepository {
  Future<List<SueModel>?> getSues();

  Future<SueModel?> getSueById(String id);

  Future<SueModel?> createSue(SueModel sue);

  Future<String?> updateSue(SueModel sue);

  Future<String?> deleteSue(String id);

  Future<List<SueModel>?> getSuesByTitle(String title);

  Future<List<SueModel>?> getSuesByUser(String user);
}
