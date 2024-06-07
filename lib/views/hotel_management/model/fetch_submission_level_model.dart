// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FetchSubmissionLevelModel {
  bool status;
  int level;
  String message;
  FetchSubmissionLevelModel({
    this.status=false,
    this.level=0,
    this.message="",
  });

  FetchSubmissionLevelModel copyWith({
    bool? status,
    int? level,
    String? message,
  }) {
    return FetchSubmissionLevelModel(
      status: status ?? this.status,
      level: level ?? this.level,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'level': level,
      'message': message,
    };
  }

  factory FetchSubmissionLevelModel.fromMap(Map<String, dynamic> map) {
    return FetchSubmissionLevelModel(
      status: map['status'] ??false,
      level: map['level'] ??0,
      message: map['message'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchSubmissionLevelModel.fromJson(String source) => FetchSubmissionLevelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FecthSubmissionLevelModel(status: $status, level: $level, message: $message)';

  @override
  bool operator ==(covariant FetchSubmissionLevelModel other) {
    if (identical(this, other)) return true;

    return
      other.status == status &&
          other.level == level &&
          other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ level.hashCode ^ message.hashCode;
}
