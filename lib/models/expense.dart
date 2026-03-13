class Expense {

  final int? id;
  final int restaurantId;
  final double amount;
  final String date;

  Expense({
    this.id,
    required this.restaurantId,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'amount': amount,
      'date': date,
    };
  }
}