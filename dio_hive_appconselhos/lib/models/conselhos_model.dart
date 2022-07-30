class Conselhos {
  Slip? slip;

  Conselhos({this.slip});

  Conselhos.fromJson(Map<String, dynamic> json) {
    slip = json['slip'] != null ? Slip.fromJson(json['slip']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (slip != null) {
      data['slip'] = slip!.toJson();
    }
    return data;
  }
}

class Slip {
  int? id;
  String? advice;

  Slip({this.id, this.advice});

  Slip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advice = json['advice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['advice'] = advice;
    return data;
  }
}