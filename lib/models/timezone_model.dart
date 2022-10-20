class Timezone {
  String? offset;
  String? description;

  Timezone({
    this.offset,
    this.description,
  });

  Timezone.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['description'] = description;
    return data;
  }
}
