// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetDetailModel {
  bool status;
  String message;
  GetDetailData? data;
  GetDetailModel({
         this.status=false,
      this.message="",
    this.data,
  });

  GetDetailModel copyWith({
    bool? status,
    String? message,
    GetDetailData? data,
  }) {
    return GetDetailModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory GetDetailModel.fromMap(Map<String, dynamic> map) {
    return GetDetailModel(
      status: map['status'] ??false,
      message: map['message'] ??"",
      data: map['data'] != null ? GetDetailData.fromMap(map['data'] as Map<String,dynamic>) : GetDetailData(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDetailModel.fromJson(String source) => GetDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetDetailModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant GetDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}


class GetDetailData {
  String hotelId;
  String hotelUniqueId;
  String hotelName;
  String hotelEmail;
  String hotelMobile;
  String hotelAddress;
  String hotelPincode;
  String hotelStatus;
  String createdat;
  String countryId;
  String stateId;
  String cityId;
  GetDetailData({
      this.hotelId="",
      this.hotelUniqueId="",
      this.hotelName="",
      this.hotelEmail="",
      this.hotelMobile="",
      this.hotelAddress="",
      this.hotelPincode="",
      this.hotelStatus="",
      this.createdat="",
      this.countryId="",
      this.stateId="",
      this.cityId="",
  });

  GetDetailData copyWith({
    String? hotelId,
    String? hotelUniqueId,
    String? hotelName,
    String? hotelEmail,
    String? hotelMobile,
    String? hotelAddress,
    String? hotelPincode,
    String? hotelStatus,
    String? createdat,
    String? countryId,
    String? stateId,
    String? cityId,
  }) {
    return GetDetailData(
      hotelId: hotelId ?? this.hotelId,
      hotelUniqueId: hotelUniqueId ?? this.hotelUniqueId,
      hotelName: hotelName ?? this.hotelName,
      hotelEmail: hotelEmail ?? this.hotelEmail,
      hotelMobile: hotelMobile ?? this.hotelMobile,
      hotelAddress: hotelAddress ?? this.hotelAddress,
      hotelPincode: hotelPincode ?? this.hotelPincode,
      hotelStatus: hotelStatus ?? this.hotelStatus,
      createdat: createdat ?? this.createdat,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
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
      'countryId': countryId,
      'stateId': stateId,
      'cityId': cityId,
    };
  }

  factory GetDetailData.fromMap(Map<String, dynamic> map) {
    return GetDetailData(
      hotelId: map['hotelId'] ??"",
      hotelUniqueId: map['hotelUniqueId'] ??"",
      hotelName: map['hotelName'] ??"",
      hotelEmail: map['hotelEmail'] ??"",
      hotelMobile: map['hotelMobile']??"",
      hotelAddress: map['hotelAddress'] ??"",
      hotelPincode: map['hotelPincode'] ??"",
      hotelStatus: map['hotelStatus'] ??"",
      createdat: map['createdat'] ??"",
      countryId: map['countryId'] ??"",
      stateId: map['stateId'] ??"",
      cityId: map['cityId'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDetailData.fromJson(String source) => GetDetailData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetDetailData(hotelId: $hotelId, hotelUniqueId: $hotelUniqueId, hotelName: $hotelName, hotelEmail: $hotelEmail, hotelMobile: $hotelMobile, hotelAddress: $hotelAddress, hotelPincode: $hotelPincode, hotelStatus: $hotelStatus, createdat: $createdat, countryId: $countryId, stateId: $stateId, cityId: $cityId)';
  }

  @override
  bool operator ==(covariant GetDetailData other) {
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
      other.countryId == countryId &&
      other.stateId == stateId &&
      other.cityId == cityId;
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
      countryId.hashCode ^
      stateId.hashCode ^
      cityId.hashCode;
  }
}
