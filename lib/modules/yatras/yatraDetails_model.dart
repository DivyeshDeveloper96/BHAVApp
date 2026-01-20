class YatraDetailsModel {
  String? remindCode;
  String? name;
  String? regStartAt;
  String? regEndAt;
  String? yatraStartAt;
  String? yatraEndAt;
  String? imageUrl;
  String? youtubeUrl;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  String? id;
  List<YatraContentBlock>? yatraContentBlock;

  YatraDetailsModel(
      {this.remindCode,
        this.name,
        this.regStartAt,
        this.regEndAt,
        this.yatraStartAt,
        this.yatraEndAt,
        this.imageUrl,
        this.youtubeUrl,
        this.status,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt,
        this.id,
        this.yatraContentBlock});

  YatraDetailsModel.fromJson(Map<String, dynamic> json) {
    remindCode = json['remind_code'];
    name = json['name'];
    regStartAt = json['reg_start_at'];
    regEndAt = json['reg_end_at'];
    yatraStartAt = json['yatra_start_at'];
    yatraEndAt = json['yatra_end_at'];
    imageUrl = json['image_url'];
    youtubeUrl = json['youtube_url'];
    status = json['status'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    id = json['id'];
    if (json['yatra_content_block'] != null) {
      yatraContentBlock = <YatraContentBlock>[];
      json['yatra_content_block'].forEach((v) {
        yatraContentBlock!.add(new YatraContentBlock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['remind_code'] = remindCode;
    data['name'] = name;
    data['reg_start_at'] = regStartAt;
    data['reg_end_at'] = regEndAt;
    data['yatra_start_at'] = yatraStartAt;
    data['yatra_end_at'] = yatraEndAt;
    data['image_url'] = imageUrl;
    data['youtube_url'] = youtubeUrl;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['id'] = id;
    if (yatraContentBlock != null) {
      data['yatra_content_block'] =
          yatraContentBlock!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YatraContentBlock {
  String? id;
  String? yatraId;
  String? title;
  String? contentHtml;
  int? sequence;
  bool? isActive;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  Null? updatedAt;

  YatraContentBlock(
      {this.id,
        this.yatraId,
        this.title,
        this.contentHtml,
        this.sequence,
        this.isActive,
        this.createdBy,
        this.createdAt,
        this.updatedBy,
        this.updatedAt});

  YatraContentBlock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    yatraId = json['yatra_id'];
    title = json['title'];
    contentHtml = json['content_html'];
    sequence = json['sequence'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['yatra_id'] = yatraId;
    data['title'] = title;
    data['content_html'] = contentHtml;
    data['sequence'] = sequence;
    data['is_active'] = isActive;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    return data;
  }
}