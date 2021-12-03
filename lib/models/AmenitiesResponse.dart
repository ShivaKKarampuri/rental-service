class AmenitiesResponse {
  bool? success;
  List<Amenities>? amenities;

  AmenitiesResponse({this.success, this.amenities});

  AmenitiesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['amenities'] != null) {
      amenities = [];
      json['amenities'].forEach((v) {
        amenities?.add(new Amenities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.amenities != null) {
      data['amenities'] = this.amenities?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amenities {
  int? id;
  String? title;

  Amenities({this.id, this.title});

  Amenities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Amenities &&
              runtimeType == other.runtimeType &&
              title == other.title;

  @override
  int get hashCode => title.hashCode;
}
