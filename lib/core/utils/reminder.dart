import 'package:flutter/material.dart';

class ReminderModel {
  final String id;
  final int scheduleId;
  final TimeOfDay time;
  bool active;

  ReminderModel(this.id, this.time, this.active, this.scheduleId);

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    final String id = json['id'];
    final int scheduleId = json['schedule_id'];
    final TimeOfDay time = TimeOfDay.fromDateTime(DateTime.parse(json['time']).toLocal());
    final bool active = json['is_active'];

    return ReminderModel(id, time, active, scheduleId);
  }
}