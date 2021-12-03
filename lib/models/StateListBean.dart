class StateListBean {
  bool? success;
  List<States>? states;

  StateListBean({this.success, this.states});

  StateListBean.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['states'] != null) {
      states = [];
      json['states'].forEach((v) {
        states?.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.states != null) {
      data['states'] = this.states?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  int? id;
  String? name;

  States({this.id, this.name});

  States.fromJson(Map<String, dynamic> json) {
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
