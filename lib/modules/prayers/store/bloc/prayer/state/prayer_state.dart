
import 'package:igrejoteca_app/modules/prayers/data/models/prayer_model.dart';

abstract class PrayerState{}

class LoadingPrayerState extends PrayerState{}

class LoadedPrayerState extends PrayerState{
  final List<PrayerModel> prayers;

  LoadedPrayerState(this.prayers);
}

class ErrorPrayerState extends PrayerState{}

class EmptyPrayerState extends PrayerState{}
