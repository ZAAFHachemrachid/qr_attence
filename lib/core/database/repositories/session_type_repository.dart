import '../models/session_type.dart';
import 'base_repository.dart';

class SessionTypeRepository extends BaseRepository<SessionType> {
  SessionTypeRepository() : super('session_type');

  Future<SessionType?> getSessionTypeById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return SessionType.fromMap(data);
  }

  Future<List<SessionType>> getAllSessionTypes() async {
    final data = await getAll();
    return data.map((e) => SessionType.fromMap(e)).toList();
  }

  Future<List<SessionType>> getMandatorySessionTypes() async {
    final data = await query('is_mandatory', true);
    return data.map((e) => SessionType.fromMap(e)).toList();
  }

  Future<SessionType?> getSessionTypeByCode(String code) async {
    final data = await query('code', code);
    if (data.isEmpty) return null;
    return SessionType.fromMap(data.first);
  }

  Future<SessionType> createSessionType(SessionType sessionType) async {
    final data = await create(sessionType.toMap());
    return SessionType.fromMap(data);
  }

  Future<SessionType> updateSessionType(SessionType sessionType) async {
    final data = await update(sessionType.typeId, sessionType.toMap());
    return SessionType.fromMap(data);
  }

  Future<void> deleteSessionType(String typeId) async {
    await delete(typeId);
  }

  Future<List<SessionType>> getSessionTypesByMaxAbsences(int maxAbsences) async {
    final data = await query('max_absences', maxAbsences);
    return data.map((e) => SessionType.fromMap(e)).toList();
  }
}
