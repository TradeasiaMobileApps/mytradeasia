import 'package:mytradeasia/features/data/model/user_sales_models/user_sales_model.dart';

class SalesLoginResponse {
  bool? status;
  SalesUserData? salesUserData;
  String? message;

  SalesLoginResponse({this.status, this.salesUserData, this.message});

  SalesLoginResponse.fromJson(Map<String, dynamic> json) {
    print("SALES DATA RESPONSE ${json['data']}");
    status = json['status'];
    salesUserData = json['data'] != null ? new SalesUserData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.salesUserData != null) {
      data['data'] = this.salesUserData!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class SalesUserData {
  UserSalesModel? user;

  SalesUserData({this.user});

  SalesUserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserSalesModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? role;
  String? socialId;
  String? loginType;
  String? email;
  String? firstName;
  String? lastName;
  String? companyName;
  String? country;
  String? dialingCode;
  String? mobileNumber;
  String? profileAvatar;
  String? timezone;
  int? isPhoneOtpVerify;
  String? status;
  String? emailVerifiedAt;
  String? lastLogin;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? isEmailVerified;
  String? countryNameCode;
  String? salesforceAccountId;
  String? salesforceContactId;
  String? cometChatUserId;
  String? token;

  User(
      {this.id,
        this.role,
        this.socialId,
        this.loginType,
        this.email,
        this.firstName,
        this.lastName,
        this.companyName,
        this.country,
        this.dialingCode,
        this.mobileNumber,
        this.profileAvatar,
        this.timezone,
        this.isPhoneOtpVerify,
        this.status,
        this.emailVerifiedAt,
        this.lastLogin,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.isEmailVerified,
        this.countryNameCode,
        this.salesforceAccountId,
        this.salesforceContactId,
        this.cometChatUserId,
        this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    socialId = json['social_id'];
    loginType = json['login_type'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyName = json['company_name'];
    country = json['country'];
    dialingCode = json['dialing_code'];
    mobileNumber = json['mobile_number'];
    profileAvatar = json['profile_avatar'];
    timezone = json['timezone'];
    isPhoneOtpVerify = json['is_phone_otp_verify'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    lastLogin = json['last_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isEmailVerified = json['is_email_verified'];
    countryNameCode = json['country_name_code'];
    salesforceAccountId = json['salesforce_account_id'];
    salesforceContactId = json['salesforce_contact_id'];
    cometChatUserId = json['comet_chat_user_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['social_id'] = this.socialId;
    data['login_type'] = this.loginType;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company_name'] = this.companyName;
    data['country'] = this.country;
    data['dialing_code'] = this.dialingCode;
    data['mobile_number'] = this.mobileNumber;
    data['profile_avatar'] = this.profileAvatar;
    data['timezone'] = this.timezone;
    data['is_phone_otp_verify'] = this.isPhoneOtpVerify;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['last_login'] = this.lastLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_email_verified'] = this.isEmailVerified;
    data['country_name_code'] = this.countryNameCode;
    data['salesforce_account_id'] = this.salesforceAccountId;
    data['salesforce_contact_id'] = this.salesforceContactId;
    data['comet_chat_user_id'] = this.cometChatUserId;
    data['token'] = this.token;
    return data;
  }
}
