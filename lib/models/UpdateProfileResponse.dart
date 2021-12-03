class UpdateProfileResponse {
  bool? success;
  String? message;
  User? user;

  UpdateProfileResponse({this.success, this.message, this.user});

  UpdateProfileResponse.fromJson(Map<String?, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? country;
  String? state;
  String? city;
  String? address;
  String? zip;
  String? profileImg;
  String? provider;
  String? providerId;
  int? firstTimeMsg;
  int? status;
  String? emailOtp;
  String? otpExpireTime;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.country,
        this.state,
        this.city,
        this.address,
        this.zip,
        this.profileImg,
        this.provider,
        this.providerId,
        this.firstTimeMsg,
        this.status,
        this.emailOtp,
        this.otpExpireTime,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
    zip = json['zip'];
    profileImg = json['profile_img'];
    provider = json['provider'];
    providerId = json['provider_id'];
    firstTimeMsg = json['first_time_msg'];
    status = json['status'];
    emailOtp = json['email_otp'];
    otpExpireTime = json['otp_expire_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['profile_img'] = this.profileImg;
    data['provider'] = this.provider;
    data['provider_id'] = this.providerId;
    data['first_time_msg'] = this.firstTimeMsg;
    data['status'] = this.status;
    data['email_otp'] = this.emailOtp;
    data['otp_expire_time'] = this.otpExpireTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
