class PriceDTO {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int quantity;

  PriceDTO({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  factory PriceDTO.fromJson(Map<String, dynamic> json) {
    return PriceDTO(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      currency: json['currency'],
      quantity: json['quantity'],
    );
  }
}
