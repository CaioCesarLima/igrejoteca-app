import 'package:flutter/material.dart';
import 'package:igrejoteca_app/core/utils/time_of_day.dart';

List<TimeOfDay> timestampsInterval({int interval = 5}) {
  List<TimeOfDay> timestamps = [];

  for (int hh in List<int>.generate(24, (int hh) => hh)) {
    for (int mm in List<int>.generate(12, (int mm) => mm * interval)) {
      timestamps.add(TimeOfDay(hour: hh, minute: mm));
    }
  }

  final TimeOfDay now = TimeOfDay.now();
  TimeOfDay time = timestamps.first;

  while (time.compareTo(now).isNegative) {
    timestamps.removeAt(0);
    timestamps.add(time);

    time = timestamps.first;
  }

  for (TimeOfDay time in timestamps) {
    if (time.compareTo(now) < 0) {
    }
  }

  return timestamps;
}

TimeOfDay timeOfDayUTC(TimeOfDay origin) {
  DateTime local = DateTime.now();
  DateTime utc = local.toUtc();

  int hourDifference = utc.hour - local.hour;
  int minuteDifference = utc.minute - local.minute;

  return TimeOfDay(
    hour: origin.hour + hourDifference,
    minute: origin.minute + minuteDifference
  );
}