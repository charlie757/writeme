class QuestionM {
  String? title;
  String? questionType = "";
  List<OptionsM>? detail;

  QuestionM({this.title, this.questionType, this.detail});

  QuestionM.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    questionType = json['questionType'];
    if (json['detail'] != null) {
      detail = <OptionsM>[];
      json['detail'].forEach((v) {
        detail!.add(new OptionsM.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionsM {
  String title = "";
  int id = 0;

  OptionsM(this.title,
        this.id);

  OptionsM.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    return data;
  }
}
