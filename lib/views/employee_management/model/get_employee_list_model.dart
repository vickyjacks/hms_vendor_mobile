// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetEmployeeList {
  bool status;
  List<GetEmployeeData> data;

  GetEmployeeList({
    this.status = false,
    this.data = const [],
  });

  GetEmployeeList copyWith({
    bool? status,
    List<GetEmployeeData>? data,
  }) {
    return GetEmployeeList(
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

  factory GetEmployeeList.fromMap(Map<String, dynamic> map) {
    return GetEmployeeList(
      status: map['status'] as bool,
      data: List<GetEmployeeData>.from(
        (map['data'] ?? const []).map<GetEmployeeData>(
              (x) => GetEmployeeData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetEmployeeList.fromJson(String source) => GetEmployeeList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetEmployeeList(status: $status, data: $data)';

  @override
  bool operator ==(covariant GetEmployeeList other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ data.hashCode;
}

class GetEmployeeData {
  String id;
  String name;
  String lastName;
  String email;
  String mobile;
  String employeeId;
  String roleId;
  String roleName;
  String status;
  String addedAt;

  GetEmployeeData({
    this.id = "",
    this.name = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.employeeId = "",
    this.roleId = "",
    this.roleName = "",
    this.status = "",
    this.addedAt = "",
  });

  GetEmployeeData copyWith({
    String? id,
    String? name,
    String? lastName,
    String? email,
    String? mobile,
    String? employeeId,
    String? roleId,
    String? roleName,
    String? status,
    String? addedAt,
  }) {
    return GetEmployeeData(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      employeeId: employeeId ?? this.employeeId,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      status: status ?? this.status,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'mobile': mobile,
      'employeeId': employeeId,
      'roleId': roleId,
      'roleName': roleName,
      'status': status,
      'addedAt': addedAt,
    };
  }

  factory GetEmployeeData.fromMap(Map<String, dynamic> map) {
    return GetEmployeeData(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      lastName: map['lastName'] ?? "",
      email: map['email'] ?? "",
      mobile: map['mobile'] ?? "",
      employeeId: map['employeeId'] ?? "",
      roleId: map['roleId'] ?? "",
      roleName: map['roleName'] ?? "",
      status: map['status'] ?? "",
      addedAt: map['addedAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory GetEmployeeData.fromJson(String source) => GetEmployeeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GetEmployeeData(id: $id, name: $name, lastName: $lastName, email: $email, mobile: $mobile, employeeId: $employeeId, roleId: $roleId, roleName: $roleName, status: $status, addedAt: $addedAt)';
  }

  @override
  bool operator ==(covariant GetEmployeeData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.lastName == lastName && other.email == email && other.mobile == mobile && other.employeeId == employeeId && other.roleId == roleId && other.roleName == roleName && other.status == status && other.addedAt == addedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ email.hashCode ^ mobile.hashCode ^ employeeId.hashCode ^ roleId.hashCode ^ roleName.hashCode ^ status.hashCode ^ addedAt.hashCode;
  }
}
