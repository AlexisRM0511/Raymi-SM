import '/rest_services/sues/sue_model.dart';
import '/rest_services/sues/sue_repository.dart';

class SueController {
  final SueRepository _sueRepository;

  SueController(this._sueRepository);

  Future<List<SueModel>?> getSues() async => _sueRepository.getSues();

  Future<SueModel?> getSueById(String id) async =>
      _sueRepository.getSueById(id);

  Future<SueModel?> createSue(SueModel sue) async =>
      _sueRepository.createSue(sue);

  Future<String?> updateSue(SueModel sue) async =>
      _sueRepository.updateSue(sue);

  Future<String?> deleteSue(String id) async => _sueRepository.deleteSue(id);

  Future<List<SueModel>?> getSuesByTitle(String title) async =>
      _sueRepository.getSuesByTitle(title);

  Future<List<SueModel>?> getSuesByUser(String user) async =>
      _sueRepository.getSuesByUser(user);
}
