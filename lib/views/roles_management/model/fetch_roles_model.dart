import 'dart:convert';
import 'package:flutter/foundation.dart';

class GetAllRolesListModel {
  final bool status;
  final List<FetchRolesListData> data;
  GetAllRolesListModel({
    required this.status,
    required this.data,
  });

  GetAllRolesListModel copyWith({
    bool? status,
    List<FetchRolesListData>? data,
  }) {
    return GetAllRolesListModel(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory GetAllRolesListModel.fromMap(Map<String, dynamic> map) {
    return GetAllRolesListModel(
      status: map['status'] ?? false,
      // data: List<FetchRolesListData>.from((map['data'] as List<int>).map<FetchRolesListData>((x) => FetchRolesListData.fromMap(x as Map<String,dynamic>),),),
      data: List<FetchRolesListData>.from(
        (map['data'] ?? const []).map<FetchRolesListData>(
          (x) => FetchRolesListData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllRolesListModel.fromJson(String source) =>
      GetAllRolesListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetAllRolesListModel(status: $status, data: $data)';

  @override
  bool operator ==(covariant GetAllRolesListModel other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class FetchRolesListData {
  final String id;
  final String roleName;
  final String status;
  FetchRolesListData({
    required this.id,
    required this.roleName,
    required this.status,
  });

  FetchRolesListData copyWith({
    String? id,
    String? roleName,
    String? status,
  }) {
    return FetchRolesListData(
      id: id ?? this.id,
      roleName: roleName ?? this.roleName,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roleName': roleName,
      'status': status,
    };
  }

  factory FetchRolesListData.fromMap(Map<String, dynamic> map) {
    return FetchRolesListData(
      id: map['_id'] ?? "",
      roleName: map['RoleName'] ?? "",
      status: map['status'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchRolesListData.fromJson(String source) =>
      FetchRolesListData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FetchRolesListData(id: $id, roleName: $roleName, status: $status)';

  @override
  bool operator ==(covariant FetchRolesListData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roleName == roleName &&
        other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ roleName.hashCode ^ status.hashCode;
}