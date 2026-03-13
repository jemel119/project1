class Restaurant {

  final int? id;
  final String name;
  final String cuisine;
  final String priceRange;
  final String openHours;
  final String notes;
  final int isFavorite;

  Restaurant({
    this.id,
    required this.name,
    required this.cuisine,
    required this.priceRange,
    required this.openHours,
    required this.notes,
    this.isFavorite = 0,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'name': name,
      'cuisine': cuisine,
      'price_range': priceRange,
      'open_hours': openHours,
      'notes': notes,
      'is_favorite': isFavorite,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {

    return Restaurant(
      id: map['id'],
      name: map['name'],
      cuisine: map['cuisine'],
      priceRange: map['price_range'],
      openHours: map['open_hours'],
      notes: map['notes'],
      isFavorite: map['is_favorite'],
    );
  }
}