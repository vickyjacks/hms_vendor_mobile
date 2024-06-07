// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetDocumentModel {
  bool status;
  String message;
  GetDocumentData? data;
  GetDocumentModel({
      this.status=false,
      this.message="",
    this.data,
  });

  GetDocumentModel copyWith({
    bool? status,
    String? message,
    GetDocumentData? data,
  }) {
    return GetDocumentModel(
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

  factory GetDocumentModel.fromMap(Map<String, dynamic> map) {
    return GetDocumentModel(
      status: map['status'] ??false,
      message: map['message']??"",
      data: map['data'] != null ? GetDocumentData.fromMap(map['data'] as Map<String,dynamic>) : GetDocumentData(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDocumentModel.fromJson(String source) => GetDocumentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetDocumentModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(covariant GetDocumentModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.message == message &&
      other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class GetDocumentData {
  String id;
  String hotelId;
  String hotelName;
  String pancard;
  String blankCheck;
  String hotelRegistration;
  GetDocumentData({
      this.id="",
      this.hotelId="",
      this.hotelName="",
      this.pancard="",
      this.blankCheck="",
      this.hotelRegistration="",
  });

  GetDocumentData copyWith({
    String? id,
    String? hotelId,
    String? hotelName,
    String? pancard,
    String? blankCheck,
    String? hotelRegistration,
  }) {
    return GetDocumentData(
      id: id ?? this.id,
      hotelId: hotelId ?? this.hotelId,
      hotelName: hotelName ?? this.hotelName,
      pancard: pancard ?? this.pancard,
      blankCheck: blankCheck ?? this.blankCheck,
      hotelRegistration: hotelRegistration ?? this.hotelRegistration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hotelId': hotelId,
      'hotelName': hotelName,
      'pancard': pancard,
      'blankCheck': blankCheck,
      'hotelRegistration': hotelRegistration,
    };
  }

  factory GetDocumentData.fromMap(Map<String, dynamic> map) {
    return GetDocumentData(
      id: map['id'] ??"",
      hotelId: map['hotelId'] ??"",
      hotelName: map['hotelName']??"",
      pancard: map['pancard'] ??"",
      blankCheck: map['blankCheck'] ??"",
      hotelRegistration: map['hotelRegistration'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory GetDocumentData.fromJson(String source) => GetDocumentData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetDocumentData(id: $id, hotelId: $hotelId, hotelName: $hotelName, pancard: $pancard, blankCheck: $blankCheck, hotelRegistration: $hotelRegistration)';
  }

  @override
  bool operator ==(covariant GetDocumentData other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.hotelId == hotelId &&
      other.hotelName == hotelName &&
      other.pancard == pancard &&
      other.blankCheck == blankCheck &&
      other.hotelRegistration == hotelRegistration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      hotelId.hashCode ^
      hotelName.hashCode ^
      pancard.hashCode ^
      blankCheck.hashCode ^
      hotelRegistration.hashCode;
  }
}
