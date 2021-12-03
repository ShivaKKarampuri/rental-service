class UserProfileResponse {
  int? _status;
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _country;
  String? _state;
  String? _city;
  String? _address;
  String? _zip;
  String? _profileImg;
  String? _provider;
  String? _providerId;
  String? _imageUrl;

  UserProfileResponse(
      {
        int? status,
        int? id,
        String? firstName,
        String? lastName,
        String? email,
        String? phone,
        String? country,
        String? state,
        String? city,
        String? address,
        String? zip,
        String? profileImg,
        String? provider,
        String? providerId,
        String? imageUrl}) {
    this._status = status;
    this._id = id;
    this._firstName = firstName;
    this._lastName = lastName;
    this._email = email;
    this._phone = phone;
    this._country = country;
    this._state = state;
    this._city = city;
    this._address = address;
    this._zip = zip;
    this._profileImg = profileImg;
    this._provider = provider;
    this._providerId = providerId;
    this._imageUrl = imageUrl;
  }
  int? get status => _status;
  set status(int? status) => _status= status;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get firstName => _firstName;
  set firstName(String? firstName) => _firstName = firstName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get country => _country;
  set country(String? country) => _country = country;
  String? get state => _state;
  set state(String? state) => _state = state;
  String? get city => _city;
  set city(String? city) => _city = city;
  String? get address => _address;
  set address(String? address) => _address = address;
  String? get zip => _zip;
  set zip(String? zip) => _zip = zip;
  String? get profileImg => _profileImg;
  set profileImg(String? profileImg) => _profileImg = profileImg;
  String? get provider => _provider;
  set provider(String? provider) => _provider = provider;
  String? get providerId => _providerId;
  set providerId(String? providerId) => _providerId = providerId;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;

  UserProfileResponse.fromJson(Map<String?, dynamic> json) {
    _status = json['status'];
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _address = json['address'];
    _zip = json['zip'];
    _profileImg = json['profile_img'];
    _provider = json['provider'];
    _providerId = json['provider_id'];
    _imageUrl = json['image_url'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['status'] = this._status;
    data['id'] = this._id;
    data['first_name'] = this._firstName;
    data['last_name'] = this._lastName;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['country'] = this._country;
    data['state'] = this._state;
    data['city'] = this._city;
    data['address'] = this._address;
    data['zip'] = this._zip;
    data['profile_img'] = this._profileImg;
    data['provider'] = this._provider;
    data['provider_id'] = this._providerId;
    data['image_url'] = this._imageUrl;
    return data;
  }
}
