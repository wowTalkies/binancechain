class ProfileModel {
  String? apiKey;
  String? badge;
  String? community;
  String? node;
  String? points;
  String? quiz;
  String? referrals;
  String? requestUrl;

  ProfileModel(
      {this.apiKey,
      this.badge,
      this.community,
      this.node,
      this.points,
      this.quiz,
      this.referrals,
      this.requestUrl});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    badge = json['badge'];
    community = json['community'];
    node = json['node'];
    points = json['points'];
    quiz = json['quiz'];
    referrals = json['referrals'];
    requestUrl = json['requestUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = this.apiKey;
    data['badge'] = this.badge;
    data['community'] = this.community;
    data['node'] = this.node;
    data['points'] = this.points;
    data['quiz'] = this.quiz;
    data['referrals'] = this.referrals;
    data['requestUrl'] = this.requestUrl;
    return data;
  }
}
