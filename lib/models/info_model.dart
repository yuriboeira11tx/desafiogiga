class Info {
  String? seed;
  int? results;
  int? page;
  String? version;

  Info({
    this.seed,
    this.results,
    this.page,
    this.version,
  });

  Info.fromJson(Map<String, dynamic> json) {
    seed = json['seed'];
    results = json['results'];
    page = json['page'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['seed'] = seed;
    data['results'] = results;
    data['page'] = page;
    data['version'] = version;
    return data;
  }
}
