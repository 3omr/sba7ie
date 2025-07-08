class Student {
  int? id;
  String? name;
  int? subscription;
  String? phoneNumber;
  int? idTeacher;

  Student(
      {this.id,
      this.name,
      this.subscription,
      this.phoneNumber,
      this.idTeacher});

  factory Student.fromJson(Map<dynamic, dynamic> json) {
    return Student(
      id: json["id"],
      name: json["name"],
      subscription: json["subscription"],
      phoneNumber: json["phoneNumber"],
      idTeacher: json["idTeacher"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "name": this.name,
      "subscription": this.subscription,
      "phoneNumber": this.phoneNumber,
      "idTeacher": this.idTeacher,
    };
  }
}
