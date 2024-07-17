class VersionModel {
  int? id;
  String? version;
  int? build;
  String? releaseDateTime;
  String? releaseDescription;
  String? appName;
  String? platform;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;

  VersionModel(
      {this.id,
      this.version,
      this.build,
      this.releaseDateTime,
      this.releaseDescription,
      this.appName,
      this.platform,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt});

  VersionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
    build = json['build'];
    releaseDateTime = json['release_date_time'];
    releaseDescription = json['release_description'];
    appName = json['app_name'];
    platform = json['platform'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    data['build'] = build;
    data['release_date_time'] = releaseDateTime;
    data['release_description'] = releaseDescription;
    data['app_name'] = appName;
    data['platform'] = platform;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}
