class Id {
  String? name;
  String? value;

  Id({
    this.name,
    this.value,
  });

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
