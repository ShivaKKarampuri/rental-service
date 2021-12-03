import 'package:rent_app/models/AmenitiesResponse.dart';

class AdDetailsResponse {
  bool? success;
  Ads? ads;

  AdDetailsResponse({this.success, this.ads});

  AdDetailsResponse.fromJson(Map<String?, dynamic> json) {
    success = json['success'];
    ads = json['ads'] != null ? new Ads.fromJson(json['ads']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['success'] = this.success;
    if (this.ads != null) {
      data['ads'] = this.ads?.toJson();
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
  String? tags;
  String? description;
  String? photos;
  String? photos1;
  String? photos2;
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
  List<Amenities>? amenities;
  Categorydata? categorydata;
  Countrydata? countrydata;
  Statedata? statedata;
  Citydata? citydata;

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
        this.categorydata,
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
    if (json['amenities'] != null) {
      amenities = [];
      json['amenities'].forEach((v) {
        amenities?.add(new Amenities.fromJson(v));
      });
    }
    categorydata = json['categorydata'] != null
        ? new Categorydata.fromJson(json['categorydata'])
        : null;
    countrydata = json['countrydata'] != null
        ? new Countrydata.fromJson(json['countrydata'])
        : null;
    statedata = json['statedata'] != null
        ? new Statedata.fromJson(json['statedata'])
        : null;
    citydata = json['citydata'] != null
        ? new Citydata.fromJson(json['citydata'])
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
    if (this.amenities != null) {
      data['amenities'] = this.amenities?.map((v) => v.toJson()).toList();
    }
    if (this.categorydata != null) {
      data['categorydata'] = this.categorydata?.toJson();
    }
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



class Categorydata {
  String? title;

  Categorydata({this.title});

  Categorydata.fromJson(Map<String?, dynamic> json) {
    title = json['title'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class Countrydata {
  int? id;
  String? name;

  Countrydata({this.id, this.name});

  Countrydata.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class Statedata {
  int? id;
  String? name;

  Statedata({this.id, this.name});

  Statedata.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
class Citydata {
  int? id;
  String? name;

  Citydata({this.id, this.name});

  Citydata.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}