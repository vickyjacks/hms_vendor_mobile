// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FetchStateModel {
  bool status;
  String message;
  List<FetchStateData> data;
  FetchStateModel({
      this.status=false,
      this.message="",
      this.data= const [],
  });

  FetchStateModel copyWith({
    bool? status,
    String? message,
    List<FetchStateData>? data,
  }) {
    return FetchStateModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory FetchStateModel.fromMap(Map<String, dynamic> map) {
    return FetchStateModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: List<FetchStateData>.from((map['data']?? const []).map<FetchStateData>((x) => FetchStateData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchStateModel.fromJson(String source) => FetchStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchStateModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant FetchStateModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
class FetchStateData {
  int stateId;
  String stateName;
  FetchStateData({
      this.stateId=0,
      this.stateName="",
  });

  FetchStateData copyWith({
    int? stateId,
    String? stateName,
  }) {
    return FetchStateData(
      stateId: stateId ?? this.stateId,
      stateName: stateName ?? this.stateName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stateId': stateId,
      'stateName': stateName,
    };
  }

  factory FetchStateData.fromMap(Map<String, dynamic> map) {
    return FetchStateData(
      stateId: map['stateId'] ??0,
      stateName: map['stateName'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchStateData.fromJson(String source) => FetchStateData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchStateData(stateId: $stateId, stateName: $stateName)';

  @override
  bool operator ==(covariant FetchStateData other) {
    if (identical(this, other)) return true;
  
    return 
      other.stateId == stateId &&
      other.stateName == stateName;
  }

  @override
  int get hashCode => stateId.hashCode ^ stateName.hashCode;
}
