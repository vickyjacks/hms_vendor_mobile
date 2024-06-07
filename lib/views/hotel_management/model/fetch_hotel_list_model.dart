// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FetchHotelListModel {
  bool status;
  String message;
  List<FetchHotelListData> hotels;
  FetchHotelListModel({
     this.status=false,
     this.message="",
     this.hotels=const [],
  });

  FetchHotelListModel copyWith({
    bool? status,
    String? message,
    List<FetchHotelListData>? hotels,
  }) {
    return FetchHotelListModel(
      status: status ?? this.status,
      message: message ?? this.message,
      hotels: hotels ?? this.hotels,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'hotels': hotels.map((x) => x.toMap()).toList(),
    };
  } 

  factory FetchHotelListModel.fromMap(Map<String, dynamic> map) {
    return FetchHotelListModel(
      status: map['status'] ??false,
      message: map['message']??"",
      hotels: List<FetchHotelListData>.from((map['hotels'] ?? const []).map<FetchHotelListData>((x) => FetchHotelListData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchHotelListModel.fromJson(String source) => FetchHotelListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FetchHotelListModel(status: $status, message: $message, hotels: $hotels)';

  @override
  bool operator ==(covariant FetchHotelListModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      listEquals(other.hotels, hotels);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ hotels.hashCode;
}

class FetchHotelListData {
  String hotelId;
  String hotelUniqueId;
  String hotelName;
  String hotelEmail;
  String hotelMobile;
  String hotelAddress;
  String hotelPincode;
  String hotelStatus;
  String createdat;
  String country;
  String states;
  String city;
  FetchHotelListData({
     this.hotelId="",
     this.hotelUniqueId="",
     this.hotelName="",
     this.hotelEmail="",
     this.hotelMobile="",
     this.hotelAddress="",
     this.hotelPincode="",
     this.hotelStatus="",
     this.createdat="",
     this.country="",
     this.states="",
     this.city="",
  });

  FetchHotelListData copyWith({
    String? hotelId,
    String? hotelUniqueId,
    String? hotelName,
    String? hotelEmail,
    String? hotelMobile,
    String? hotelAddress,
    String? hotelPincode,
    String? hotelStatus,
    String? createdat,
    String? country,
    String? states,
    String? city,
  }) {
    return FetchHotelListData(
      hotelId: hotelId ?? this.hotelId,
      hotelUniqueId: hotelUniqueId ?? this.hotelUniqueId,
      hotelName: hotelName ?? this.hotelName,
      hotelEmail: hotelEmail ?? this.hotelEmail,
      hotelMobile: hotelMobile ?? this.hotelMobile,
      hotelAddress: hotelAddress ?? this.hotelAddress,
      hotelPincode: hotelPincode ?? this.hotelPincode,
      hotelStatus: hotelStatus ?? this.hotelStatus,
      createdat: createdat ?? this.createdat,
      country: country ?? this.country,
      states: states ?? this.states,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotelId': hotelId,
      'hotelUniqueId': hotelUniqueId,
      'hotelName': hotelName,
      'hotelEmail': hotelEmail,
      'hotelMobile': hotelMobile,
      'hotelAddress': hotelAddress,
      'hotelPincode': hotelPincode,
      'hotelStatus': hotelStatus,
      'createdat': createdat,
      'country': country,
      'states': states,
      'city': city,
    };
  }

  factory FetchHotelListData.fromMap(Map<String, dynamic> map) {
    return FetchHotelListData(
      hotelId: map['hotelId'] ??"",
      hotelUniqueId: map['hotelUniqueId'] ??"",
      hotelName: map['hotelName'] ??"",
      hotelEmail: map['hotelEmail']  ??"",
      hotelMobile: map['hotelMobile']  ??"",
      hotelAddress: map['hotelAddress']  ??"",
      hotelPincode: map['hotelPincode']  ??"",
      hotelStatus: map['hotelStatus']  ??"",
      createdat: map['createdat']  ??"",
      country: map['country']  ??"",
      states: map['states']  ??"",
      city: map['city']  ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchHotelListData.fromJson(String source) => FetchHotelListData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchHotelListData(hotelId: $hotelId, hotelUniqueId: $hotelUniqueId, hotelName: $hotelName, hotelEmail: $hotelEmail, hotelMobile: $hotelMobile, hotelAddress: $hotelAddress, hotelPincode: $hotelPincode, hotelStatus: $hotelStatus, createdat: $createdat, country: $country, states: $states, city: $city)';
  }

  @override
  bool operator ==(covariant FetchHotelListData other) {
    if (identical(this, other)) return true;
  
    return 
      other.hotelId == hotelId &&
      other.hotelUniqueId == hotelUniqueId &&
      other.hotelName == hotelName &&
      other.hotelEmail == hotelEmail &&
      other.hotelMobile == hotelMobile &&
      other.hotelAddress == hotelAddress &&
      other.hotelPincode == hotelPincode &&
      other.hotelStatus == hotelStatus &&
      other.createdat == createdat &&
      other.country == country &&
      other.states == states &&
      other.city == city;
  }

  @override
  int get hashCode {
    return hotelId.hashCode ^
      hotelUniqueId.hashCode ^
      hotelName.hashCode ^
      hotelEmail.hashCode ^
      hotelMobile.hashCode ^
      hotelAddress.hashCode ^
      hotelPincode.hashCode ^
      hotelStatus.hashCode ^
      createdat.hashCode ^
      country.hashCode ^
      states.hashCode ^
      city.hashCode;
  }
}
