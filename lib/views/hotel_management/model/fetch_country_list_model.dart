// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class FetchCountryModel {
  bool status;
  String message;
  List<FetchCountryData> data;
  FetchCountryModel({
     this.status=false,
     this.message="",
     this.data=const [],
  });

  FetchCountryModel copyWith({
    bool? status,
    String? message,
    List<FetchCountryData>? data,
  }) {
    return FetchCountryModel(
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

  factory FetchCountryModel.fromMap(Map<String, dynamic> map) {
    return FetchCountryModel(
      status: map['status'] ??false,
      message: map['message'] ??"",
      data: List<FetchCountryData>.from((map['data'] ??const []).map<FetchCountryData>((x) => FetchCountryData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchCountryModel.fromJson(String source) => FetchCountryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchCountryModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant FetchCountryModel other) {
    if (identical(this, other)) return true;

    return
      other.status == status &&
      other.message == message &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class FetchCountryData {
  int countryId;
  String sortname;
  String countryName;
  FetchCountryData({
      this.countryId=0,
      this.sortname="",
      this.countryName="",
  });

  FetchCountryData copyWith({
    int? countryId,
    String? sortname,
    String? countryName,
  }) {
    return FetchCountryData(
      countryId: countryId ?? this.countryId,
      sortname: sortname ?? this.sortname,
      countryName: countryName ?? this.countryName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'countryId': countryId,
      'sortname': sortname,
      'countryName': countryName,
    };
  }

  factory FetchCountryData.fromMap(Map<String, dynamic> map) {
    return FetchCountryData(
      countryId: map['countryId'] ??0,
      sortname: map['sortname'] ??"",
      countryName: map['countryName'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchCountryData.fromJson(String source) => FetchCountryData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchCountryData(countryId: $countryId, sortname: $sortname, countryName: $countryName)';

  @override
  bool operator ==(covariant FetchCountryData other) {
    if (identical(this, other)) return true;

    return
      other.countryId == countryId &&
      other.sortname == sortname &&
      other.countryName == countryName;
  }

  @override
  int get hashCode => countryId.hashCode ^ sortname.hashCode ^ countryName.hashCode;
}
