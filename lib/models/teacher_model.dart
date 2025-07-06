class Teacher {
  int? id;
  String? name;
  int? salary;

  Teacher({this.id, this.name, this.salary});

  factory Teacher.fromJson(Map<dynamic, dynamic> json) {
    return Teacher(
      id: json["id"],
      name: json["name"],
      salary: json["salary"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "name": this.name,
      "salary": this.salary,
    };
  }
}
