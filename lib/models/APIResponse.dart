class APIResponse {
  User? user;
  String? token;
  bool? success;
  String? errors;
  String? message;


  APIResponse({this.user, this.token, this.success});

  APIResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    success = json['success'];
    if( json['errors']!=null){
      errors = json['errors'];
    }
    if( json['message']!=null){
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    data['token'] = this.token;
    data['success'] = this.success;
    data['errors'] = this.errors;
    data['message'] = this.message;
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.firstName,
        this.lastName,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
