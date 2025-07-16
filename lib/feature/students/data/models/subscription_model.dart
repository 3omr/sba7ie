class Subscription {
  int? id;
  int? idStudent;
  int? money;
  String? date;

  Subscription({this.id, this.idStudent, this.money, this.date});

  factory Subscription.fromJson(Map<dynamic, dynamic> json) {
    return Subscription(
      id: json["id"],
      idStudent: json["idStudent"],
      money: json["money"],
      date: json["date"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "idStudent": idStudent,
      "money": money,
      "date": date,
    };
  }
}
