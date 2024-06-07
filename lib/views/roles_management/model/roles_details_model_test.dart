// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GetRoleDetailModel {
  bool status;
  RoleData ? roleData;
  List<PermissionData> permissionData;
  GetRoleDetailModel({
     this.status=false,
     this.roleData,
     this.permissionData= const[],
  });

  GetRoleDetailModel copyWith({
    bool? status,
    RoleData? roleData,
    List<PermissionData>? permissionData,
  }) {
    return GetRoleDetailModel(
      status: status ?? this.status,
      roleData: roleData ?? this.roleData,
      permissionData: permissionData ?? this.permissionData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'roleData': roleData?.toMap(),
      'permissionData': permissionData.map((x) => x.toMap()).toList(),
    };
  }

  factory GetRoleDetailModel.fromMap(Map<String, dynamic> map) {
    return GetRoleDetailModel(
      status: map['status'] as bool,
      roleData: RoleData.fromMap(map['roleData'] as Map<String,dynamic>),
      permissionData: List<PermissionData>.from((map['permissionData'] ?? const[]).map<PermissionData>((x) => PermissionData.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetRoleDetailModel.fromJson(String source) => GetRoleDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GetRoleDetailModel(status: $status, roleData: $roleData, permissionData: $permissionData)';

  @override
  bool operator ==(covariant GetRoleDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.status == status &&
      other.roleData == roleData &&
      listEquals(other.permissionData, permissionData);
  }

  @override
  int get hashCode => status.hashCode ^ roleData.hashCode ^ permissionData.hashCode;
}

class RoleData {
  String roleid;
  String roleName;
  String status;
  RoleData({
     this.roleid="", 
     this.roleName="",
     this.status="",
  });

  RoleData copyWith({
    String? roleid,
    String? roleName,
    String? status,
  }) {
    return RoleData(
      roleid: roleid ?? this.roleid,
      roleName: roleName ?? this.roleName,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roleid': roleid,
      'roleName': roleName,
      'status': status,
    };
  }

  factory RoleData.fromMap(Map<String, dynamic> map) {
    return RoleData(
      roleid: map['roleid']??"",
      roleName: map['roleName']??"",
      status: map['status'] ??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory RoleData.fromJson(String source) => RoleData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RoleData(roleid: $roleid, roleName: $roleName, status: $status)';

  @override
  bool operator ==(covariant RoleData other) {
    if (identical(this, other)) return true;
  
    return 
      other.roleid == roleid &&
      other.roleName == roleName &&
      other.status == status;
  }

  @override
  int get hashCode => roleid.hashCode ^ roleName.hashCode ^ status.hashCode;
}


class PermissionData {
  String labelTitle;
  String keyName;
  bool checked;
  PermissionData({
     this.labelTitle="",
     this.keyName="",
     this.checked=false,
  });

  PermissionData copyWith({
    String? labelTitle,
    String? keyName,
    bool? checked,
  }) {
    return PermissionData(
      labelTitle: labelTitle ?? this.labelTitle,
      keyName: keyName ?? this.keyName,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'labelTitle': labelTitle,
      'keyName': keyName,
      'checked': checked,
    };
  }

  factory PermissionData.fromMap(Map<String, dynamic> map) {
    return PermissionData(
      labelTitle: map['labelTitle'] ??"",
      keyName: map['keyName'] ??"",
      checked: map['checked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionData.fromJson(String source) => PermissionData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PermissionData(labelTitle: $labelTitle, keyName: $keyName, checked: $checked)';

  @override
  bool operator ==(covariant PermissionData other) {
    if (identical(this, other)) return true;
  
    return 
      other.labelTitle == labelTitle &&
      other.keyName == keyName &&
      other.checked == checked;
  }

  @override
  int get hashCode => labelTitle.hashCode ^ keyName.hashCode ^ checked.hashCode;
}
