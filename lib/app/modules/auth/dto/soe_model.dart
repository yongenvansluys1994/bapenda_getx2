class Soe {
  String? personalNumber;
  String? personalName;
  String? personalTitle;
  String? personalUnit;
  String? personalBirthPlace;
  String? personalBirthDate;
  String? personalGrade;
  String? personalJobDesc;
  String? personalEmail;

  Soe({
    this.personalNumber,
    this.personalName,
    this.personalTitle,
    this.personalUnit,
    this.personalBirthPlace,
    this.personalBirthDate,
    this.personalGrade,
    this.personalJobDesc,
    this.personalEmail,
  });

  Soe.fromJson(Map<String, dynamic> json) {
    personalNumber = json['personalNumber'];
    personalName = json['personalName'];
    personalTitle = json['personalTitle'];
    personalUnit = json['personalUnit'];
    personalBirthPlace = json['personalBirthPlace'];
    personalBirthDate = json['personalBirthDate'];
    personalGrade = json['personalGrade'];
    personalJobDesc = json['personalJobDesc'];
    personalEmail = json['personalEmail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['personalNumber'] = personalNumber;
    data['personalName'] = personalName;
    data['personalTitle'] = personalTitle;
    data['personalUnit'] = personalUnit;
    data['personalBirthPlace'] = personalBirthPlace;
    data['personalBirthDate'] = personalBirthDate;
    data['personalGrade'] = personalGrade;
    data['personalJobDesc'] = personalJobDesc;
    data['personalEmail'] = personalEmail;
    return data;
  }
}
