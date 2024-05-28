import 'package:equatable/equatable.dart';

class UserSalesEntity {
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

   UserSalesEntity(
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

  @override
  List<Object?> get props {
    return [
      id,
      role,
      socialId,
      loginType,
      email,
      firstName,
      lastName,
      companyName,
      country,
      dialingCode,
      mobileNumber,
      profileAvatar,
      timezone,
      isPhoneOtpVerify,
      status,
      emailVerifiedAt,
      lastLogin,
      createdAt,
      updatedAt,
      deletedAt,
      isEmailVerified,
      countryNameCode,
      salesforceAccountId,
      salesforceContactId,
      cometChatUserId,
      token
    ];
  }
}
