class TeeTime {
  final int id;
  final DateTime teeTime;
  final int groupSize;
  final List<int> userIds;
  final int golfCourseId;
  final bool green;
  final bool transport;
  final int holes;
  final int adults;
  final int juniors;
  final String? note;

  TeeTime({
    required this.id,
    required this.teeTime,
    required this.groupSize,
    required this.userIds,
    required this.golfCourseId,
    required this.green,
    required this.transport,
    required this.holes,
    required this.adults,
    required this.juniors,
    this.note,
  });

  factory TeeTime.fromJson(Map<String, dynamic> json) {
    return TeeTime(
      id: json['id'],
      teeTime: DateTime.parse(json['teeTime']),
      groupSize: json['groupSize'],
      userIds: List<int>.from(json['userIds']),
      golfCourseId: json['golfCourseId'],
      green: json['green'],
      transport: json['transport'],
      holes: json['holes'],
      adults: json['adults'],
      juniors: json['juniors'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teeTime': teeTime.toIso8601String(),
      'groupSize': groupSize,
      'userIds': userIds,
      'golfCourseId': golfCourseId,
      'green': green,
      'transport': transport,
      'holes': holes,
      'adults': adults,
      'juniors': juniors,
      'note': note,
    };
  }
}
