import '../models/qr_code.dart';
import 'base_repository.dart';

class QRCodeRepository extends BaseRepository<QRCode> {
  QRCodeRepository() : super('qr_code');

  Future<QRCode?> getQRCodeById(String id) async {
    final data = await getById(id);
    if (data == null) return null;
    return QRCode.fromMap(data);
  }

  Future<List<QRCode>> getAllQRCodes() async {
    final data = await getAll();
    return data.map((e) => QRCode.fromMap(e)).toList();
  }

  Future<List<QRCode>> getQRCodesBySession(String sessionId) async {
    final data = await query('session_id', sessionId);
    return data.map((e) => QRCode.fromMap(e)).toList();
  }

  Future<QRCode> createQRCode(QRCode qrCode) async {
    final data = await create(qrCode.toMap());
    return QRCode.fromMap(data);
  }

  Future<QRCode> updateQRCode(QRCode qrCode) async {
    final data = await update(qrCode.qrId, qrCode.toMap());
    return QRCode.fromMap(data);
  }

  Future<void> deleteQRCode(String qrId) async {
    await delete(qrId);
  }

  Future<List<QRCode>> getValidQRCodes() async {
    final now = DateTime.now().toUtc().toIso8601String();
    final response = await table.select().gt(
      'generated_time + validity_duration * interval \'1 second\'',
      now,
    );
    return response.map((e) => QRCode.fromMap(e)).toList();
  }

  Future<bool> isQRCodeValid(String qrId) async {
    final qrCode = await getQRCodeById(qrId);
    if (qrCode == null) return false;
    return qrCode.isValid;
  }

  Future<QRCode?> getLatestQRCodeForSession(String sessionId) async {
    final response = await table
        .select()
        .eq('session_id', sessionId)
        .order('generated_time', ascending: false)
        .limit(1);
    if (response.isEmpty) return null;
    return QRCode.fromMap(response.first);
  }
}
