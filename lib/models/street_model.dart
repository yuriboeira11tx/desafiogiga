class Street {
  int? number;
  String? name;

  Street({
    this.number,
    this.name,
  });

  Street.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['name'] = name;
    return data;
  }
}
