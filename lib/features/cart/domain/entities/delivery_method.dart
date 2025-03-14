class DeliveryMethod {
  final String id;
  final String name;
  final String description;
  final double price;
  final String estimatedDays;
  final bool isPremiumFree;
  final bool isSelected;

  const DeliveryMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDays,
    this.isPremiumFree = false,
    this.isSelected = false,
  });

  DeliveryMethod copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? estimatedDays,
    bool? isPremiumFree,
    bool? isSelected,
  }) {
    return DeliveryMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      estimatedDays: estimatedDays ?? this.estimatedDays,
      isPremiumFree: isPremiumFree ?? this.isPremiumFree,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
