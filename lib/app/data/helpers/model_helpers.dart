
class ModelHelpers {
  Map<String, dynamic> fromDocument(dynamic data) {
    data['createdAt'] = dateFromDocument(data['createdAt']);

    if (data['updatedAt'] != null) {
      data['updatedAt'] = dateFromDocument(data['updatedAt']);
    } else {
      data['updatedAt'] = data['createdAt'];
    }
    return data;
  }

  Map<String, dynamic> toDocument(Map<String, dynamic> json) {
    json = json..remove('id');
    json['createdAt'] = dateToDocument(json['createdAt']);
    json['updatedAt'] = dateToDocument(json['updatedAt']);
    return json;
  }

  String dateFromDocument(dynamic date) {
    if (date != null) {
      return date.toDate().toString();
    }
    return DateTime.now().toString();
  }

  DateTime dateToDocument(String? date) {
    if (date != null) {
      return DateTime.parse(date);
    }
    return DateTime.now();
  }
}
