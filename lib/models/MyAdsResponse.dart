class MyAdsResponse {
  bool? success;
  List<Ads>? ads;

  MyAdsResponse({this.success, this.ads});

  MyAdsResponse.fromJson(Map<String?, dynamic> json) {
    success = json['success'];
    if (json['ads'] != null) {
      ads = [];
      json['ads'].forEach((v) {
        ads?.add(new Ads.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['success'] = this.success;
    if (this.ads != null) {
      data['ads'] = this.ads?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  int? id;
  dynamic? category;
  int? userId;
  dynamic? subCategory;
  String? title;
  int? price;
  dynamic? tags;
  String? description;
  dynamic? photos;
  dynamic? photos1;
  dynamic? photos2;
  dynamic? countryId;
  dynamic? stateId;
  dynamic? cityId;
  dynamic? strAddress;
  int? status;
  String? type;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  dynamic? pincode;
  dynamic? beds;
  dynamic? halls;
  dynamic? bathroom;
  dynamic? space;
  dynamic? year;
  dynamic? floors;
  String? amenities;
  Countrydata? countrydata;
  Countrydata? statedata;
  Countrydata? citydata;

  Ads(
      {this.id,
        this.category,
        this.userId,
        this.subCategory,
        this.title,
        this.price,
        this.tags,
        this.description,
        this.photos,
        this.photos1,
        this.photos2,
        this.countryId,
        this.stateId,
        this.cityId,
        this.strAddress,
        this.status,
        this.type,
        this.contactName,
        this.contactEmail,
        this.contactPhone,
        this.pincode,
        this.beds,
        this.halls,
        this.bathroom,
        this.space,
        this.year,
        this.floors,
        this.amenities,
        this.countrydata,
        this.statedata,
        this.citydata});

  Ads.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    category = json['category'];
    userId = json['user_id'];
    subCategory = json['sub_category'];
    title = json['title'];
    price = json['price'];
    tags = json['tags'];
    description = json['description'];
    photos = json['photos'];
    photos1 = json['photos1'];
    photos2 = json['photos2'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    strAddress = json['str_address'];
    status = json['status'];
    type = json['type'];
    contactName = json['contact_name'];
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    pincode = json['pincode'];
    beds = json['beds'];
    halls = json['halls'];
    bathroom = json['bathroom'];
    space = json['space'];
    year = json['year'];
    floors = json['floors'];
    amenities = json['amenities'];
    countrydata = json['countrydata'] != null
        ? new Countrydata.fromJson(json['countrydata'])
        : null;
    statedata = json['statedata'] != null
        ? new Countrydata.fromJson(json['statedata'])
        : null;
    citydata = json['citydata'] != null
        ? new Countrydata.fromJson(json['citydata'])
        : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['user_id'] = this.userId;
    data['sub_category'] = this.subCategory;
    data['title'] = this.title;
    data['price'] = this.price;
    data['tags'] = this.tags;
    data['description'] = this.description;
    data['photos'] = this.photos;
    data['photos1'] = this.photos1;
    data['photos2'] = this.photos2;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['str_address'] = this.strAddress;
    data['status'] = this.status;
    data['type'] = this.type;
    data['contact_name'] = this.contactName;
    data['contact_email'] = this.contactEmail;
    data['contact_phone'] = this.contactPhone;
    data['pincode'] = this.pincode;
    data['beds'] = this.beds;
    data['halls'] = this.halls;
    data['bathroom'] = this.bathroom;
    data['space'] = this.space;
    data['year'] = this.year;
    data['floors'] = this.floors;
    data['amenities'] = this.amenities;
    if (this.countrydata != null) {
      data['countrydata'] = this.countrydata?.toJson();
    }
    if (this.statedata != null) {
      data['statedata'] = this.statedata?.toJson();
    }
    if (this.citydata != null) {
      data['citydata'] = this.citydata?.toJson();
    }
    return data;
  }
}

class Countrydata {
  String? name;

  Countrydata({this.name});

  Countrydata.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
