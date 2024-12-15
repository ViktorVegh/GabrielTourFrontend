import 'drive_dto.dart';

class DrivesCalendarDTO {
  final int calendarId;
  final String monthStartDate;
  final String monthEndDate;
  final List<DriveDTO> drives;

  DrivesCalendarDTO({
    required this.calendarId,
    required this.monthStartDate,
    required this.monthEndDate,
    required this.drives,
  });

  factory DrivesCalendarDTO.fromJson(Map<String, dynamic> json) {
    return DrivesCalendarDTO(
      calendarId: json['calendarId'],
      monthStartDate: json['monthStartDate'],
      monthEndDate: json['monthEndDate'],
      drives: (json['drives'] as List<dynamic>)
          .map((drive) => DriveDTO.fromJson(drive))
          .toList(),
    );
  }
}
