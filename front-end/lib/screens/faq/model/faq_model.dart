class FAQModel {
  String? answer;
  String? question;

  FAQModel({this.answer, this.question});

  FAQModel.fromJson(Map<String, dynamic> json) {
    answer = json['Answer'];
    question = json['Question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Answer'] = this.answer;
    data['Question'] = this.question;
    return data;
  }
}
