class UserModel {
  String userId;
  int roleId;
  String wlId;
  String name;
  String firmName;
  String address;
  String city;
  String pinCode;
  String state;
  String country;
  String mobile;
  String uplineId;
  String email;
  String createdDate;
  String createdTime;
  double balance;
  int status;
  String delFlag;
  String tranPin;
  double lockedAmount;
  String pan;
  String aadhaar;
  String district;
  String officialInfo;
  String empType;
  String joiningDate;
  String joiningTime;
  String resignDate;
  String resignTime;
  String assignedTo;
  bool enabled;
  String username;
  List<Authority> authorities;
  bool credentialsNonExpired;
  bool accountNonExpired;
  bool accountNonLocked;

  UserModel({
    required this.userId,
    required this.roleId,
    required this.wlId,
    required this.name,
    required this.firmName,
    required this.address,
    required this.city,
    required this.pinCode,
    required this.state,
    required this.country,
    required this.mobile,
    required this.uplineId,
    required this.email,
    required this.createdDate,
    required this.createdTime,
    required this.balance,
    required this.status,
    required this.delFlag,
    required this.tranPin,
    required this.lockedAmount,
    required this.pan,
    required this.aadhaar,
    required this.district,
    required this.officialInfo,
    required this.empType,
    required this.joiningDate,
    required this.joiningTime,
    required this.resignDate,
    required this.resignTime,
    required this.assignedTo,
    required this.enabled,
    required this.username,
    required this.authorities,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
    required this.accountNonLocked,
  });

  // Factory method to create a UserModel instance from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      roleId: json['roleId'] ?? '',
      wlId: json['wlId'] ?? '',
      name: json['name'] ?? '',
      firmName: json['firmName'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      pinCode: json['pinCode'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      mobile: json['mobile'] ?? '',
      uplineId: json['uplineId'] ?? '',
      email: json['email'] ?? '',
      createdDate: json['createdDate'] ?? '',
      createdTime: json['createdTime'] ?? '',
      balance: json['balance'] ?? 0.0,
      status: json['status'] ?? 0,
      delFlag: json['delFlag'] ?? '',
      tranPin: json['tranPin'] ?? '',
      lockedAmount: json['lockedAmount'] ?? 0.0,
      pan: json['pan'] ?? '',
      aadhaar: json['aadhaar'] ?? '',
      district: json['district'] ?? '',
      officialInfo: json['officialInfo'] ?? '',
      empType: json['empType'] ?? '',
      joiningDate: json['joiningDate'] ?? '',
      joiningTime: json['joiningTime'] ?? '',
      resignDate: json['resignDate'] ?? '',
      resignTime: json['resignTime'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      enabled: json['enabled'] ?? false,
      username: json['username'] ?? '',
      authorities: (json['authorities'] ?? [])
          .map<Authority>((authJson) => Authority.fromJson(authJson))
          .toList(),
      credentialsNonExpired: json['credentialsNonExpired'] ?? false,
      accountNonExpired: json['accountNonExpired'] ?? false,
      accountNonLocked: json['accountNonLocked'] ?? false,
    );
  }


}

class Authority {
  String authority;

  Authority({
    required this.authority,
  });

  // Factory method to create an Authority instance from JSON
  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      authority: json['authority'] ?? '',
    );
  }
}
