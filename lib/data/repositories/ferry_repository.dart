import '../models/ferry_schedule.dart';
import '../../core/utils/logger_util.dart';

class FerryRepository {
  /// Statik feribot saatlerini getirir
  Future<List<FerrySchedule>> getFerrySchedules() async {
    try {
      AppLogger.info('Feribot saatleri getiriliyor...');
      
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Statik veri
      return [
        FerrySchedule(
          direction: 'Lapseki → Gelibolu',
          times: ['07:00', '09:00', '11:00', '13:00', '15:00', '17:00', '19:00', '21:00'],
        ),
        FerrySchedule(
          direction: 'Gelibolu → Lapseki',
          times: ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00', '22:00'],
        ),
      ];
    } catch (e) {
      AppLogger.error('Feribot saatleri getirilirken hata:', e);
      return [];
    }
  }
}

