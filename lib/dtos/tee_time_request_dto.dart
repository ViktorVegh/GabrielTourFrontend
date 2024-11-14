class TeeTimeRequestDTO {
  final DateTime teeTime;
  final int groupSize;
  final List<int> userIds;
  final int golfCourseId;
  final bool green;
  final int holes;
  final int adults;
  final int juniors;
  final String? note;

  TeeTimeRequestDTO({
    required this.teeTime,
    required this.groupSize,
    required this.userIds,
    required this.golfCourseId,
    required this.green,
    required this.holes,
    required this.adults,
    required this.juniors,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'teeTime': teeTime.toIso8601String(),
      'groupSize': groupSize,
      'userIds': userIds,
      'golfCourseId': golfCourseId,
      'green': green,
      'holes': holes,
      'adults': adults,
      'juniors': juniors,
      'note': note,
    };
  }
}
