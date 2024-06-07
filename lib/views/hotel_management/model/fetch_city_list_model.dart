// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FetchCityModel { 
  bool status;
  String message; 
  List<FetchCityData> data; 
  FetchCityModel({
     this.status=false,
     this.message="",
     this.data=const [],
  }); 

  FetchCityModel copyWith({
    bool? status,
    String? message,
    List<FetchCityData>? data,
  }) {
    return FetchCityModel(
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

  factory FetchCityModel.fromMap(Map<String, dynamic> map) {
    return FetchCityModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: List<FetchCityData>.from((map['data'] ??const[]).map<FetchCityData>((x) => FetchCityData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchCityModel.fromJson(String source) => FetchCityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchCityModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant FetchCityModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class FetchCityData {
  String cityId;
  String cityName;
  FetchCityData({
      this.cityId="",
      this.cityName="",
  });

  FetchCityData copyWith({
    String? cityId,
    String? cityName,
  }) {
    return FetchCityData(
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityId': cityId,
      'cityName': cityName,
    };
  }

  factory FetchCityData.fromMap(Map<String, dynamic> map) {
    return FetchCityData(
      cityId: map['cityId'] ??"",
      cityName: map['cityName'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchCityData.fromJson(String source) => FetchCityData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchCityData(cityId: $cityId, cityName: $cityName)';

  @override
  bool operator ==(covariant FetchCityData other) {
    if (identical(this, other)) return true;
  
    return 
      other.cityId == cityId &&
      other.cityName == cityName;
  }

  @override
  int get hashCode => cityId.hashCode ^ cityName.hashCode;
}

