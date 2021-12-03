class CityListBean {
  bool? success;
  List<Cities>? cities;

  CityListBean({this.success, this.cities});

  CityListBean.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['cities'] != null) {
      cities = [];
      json['cities'].forEach((v) {
        cities?.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.cities != null) {
      data['cities'] = this.cities?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? name;

  Cities({this.id, this.name});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
