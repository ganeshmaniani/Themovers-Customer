class ImageSliderModel {
  final bool? apiSuccess;
  final List<CustomerSlideImages>? customerSlideImages;
  final String? path;

  ImageSliderModel({
    this.apiSuccess,
    this.customerSlideImages,
    this.path,
  });

  ImageSliderModel.fromJson(Map<String, dynamic> json)
      : apiSuccess = json['Api_success'] as bool?,
        customerSlideImages = (json['customer_slide_images'] as List?)
            ?.map((dynamic e) =>
                CustomerSlideImages.fromJson(e as Map<String, dynamic>))
            .toList(),
        path = json['path'] as String?;

  Map<String, dynamic> toJson() => {
        'Api_success': apiSuccess,
        'customer_slide_images':
            customerSlideImages?.map((e) => e.toJson()).toList(),
        'path': path
      };
}

class CustomerSlideImages {
  final int? id;
  final String? name;
  final String? file;
  final int? createdBy;
  final String? createdAt;
  final String? deleted;
  final dynamic deletedReason;

  CustomerSlideImages({
    this.id,
    this.name,
    this.file,
    this.createdBy,
    this.createdAt,
    this.deleted,
    this.deletedReason,
  });

  CustomerSlideImages.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        file = json['file'] as String?,
        createdBy = json['created_by'] as int?,
        createdAt = json['created_at'] as String?,
        deleted = json['deleted'] as String?,
        deletedReason = json['deleted_reason'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
        'created_by': createdBy,
        'created_at': createdAt,
        'deleted': deleted,
        'deleted_reason': deletedReason
      };
}
