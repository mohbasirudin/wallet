class ModelWallet {
  ModelWallet({
    required this.id,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.amount,
    required this.month,
    required this.year,
  });

  final int id;
  final String note;
  final String createdAt;
  final String updatedAt;
  final String type;
  final String amount;
  final String month;
  final String year;

  factory ModelWallet.fromMap(Map<String, dynamic> json) => ModelWallet(
        id: json["id"],
        note: json["note"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        type: json["type"],
        amount: json["amount"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "note": note,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "type": type,
        "amount": amount,
        "month": month,
        "year": year,
      };
}
