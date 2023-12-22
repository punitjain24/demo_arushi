class DashboardResponse {
  String? title;
  String? name;
  String? slug;
  String? description;
  DashboardSchema? schema;

  DashboardResponse(
      {this.title, this.name, this.slug, this.description, this.schema});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    schema =
    json['schema'] != null ? new DashboardSchema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    if (this.schema != null) {
      data['schema'] = this.schema!.toJson();
    }
    return data;
  }
}

class DashboardSchema {
  List<Fields>? fields;

  DashboardSchema({this.fields});

  DashboardSchema.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(new Fields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fields {
  String? type;
  int? version;
  FieldsSchema? schema;

  Fields({this.type, this.version, this.schema});

  Fields.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    version = json['version'];
    schema =
    json['schema'] != null ? new FieldsSchema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['version'] = this.version;
    if (this.schema != null) {
      data['schema'] = this.schema!.toJson();
    }
    return data;
  }
}

class FieldsSchema {
  String? name;
  String? label;
  bool? hidden;
  bool? readonly;
  List<Options>? options;


  FieldsSchema(
      {this.name,
        this.label,
        this.hidden,
        this.readonly,
        this.options,
       });

  FieldsSchema.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    hidden = json['hidden'];
    readonly = json['readonly'];
    if (json['options'] == null) {

    }
    else{
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['label'] = this.label;
    data['hidden'] = this.hidden;
    data['readonly'] = this.readonly;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Options {
  String? key;
  String? value;
  int? isSelected;

  Options({this.key, this.value,this.isSelected});

  Options.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['isSelected'] = this.isSelected;
    return data;
  }
}

