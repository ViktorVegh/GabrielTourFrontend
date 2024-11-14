class TeeTime {
  final int id;
  final DateTime teeTime;
  final int groupSize;
  final List<int> userIds; // List of user IDs
  final int golfCourseId; // Changed to int for golfCourseId
  final bool green;
  final int holes;
  final int adults;
  final int juniors;
  final String? note;

  TeeTime({
    required this.id,
    required this.teeTime,
    required this.groupSize,
    required this.userIds,
    required this.golfCourseId, // Using golfCourseId as an integer
    required this.green,
    required this.holes,
    required this.adults,
    required this.juniors,
    this.note,
  });

  // Convert JSON to TeeTime
  factory TeeTime.fromJson(Map<String, dynamic> json) {
    return TeeTime(
      id: json['id'],
      teeTime: DateTime.parse(json['teeTime']),
      groupSize: json['groupSize'],
      userIds: List<int>.from(json['userIds']),
      golfCourseId: json['golfCourseId'], // Deserialize as an integer
      green: json['green'],
      holes: json['holes'],
      adults: json['adults'],
      juniors: json['juniors'],
      note: json['note'],
    );
  }

  // Convert TeeTime to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teeTime': teeTime.toIso8601String(),
      'groupSize': groupSize,
      'userIds': userIds,
      'golfCourseId': golfCourseId, // Serialize golfCourseId as integer
      'green': green,
      'holes': holes,
      'adults': adults,
      'juniors': juniors,
      'note': note,
    };
  }
}
