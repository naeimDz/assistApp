class Address {
  final String? street;
  final String? city;
  final String? province;
  final String? zipCode;

  Address({
    this.street,
    this.city,
    this.province,
    this.zipCode,
  });

  // Factory constructor for Address (optional)
  factory Address.fromJson(Map<String, dynamic>? json) => Address(
        street: json?['street'] as String,
        city: json?['city'] as String,
        province: json?['province'] as String,
        zipCode: json?['zipCode'] as String,
      );

  // toJson method for Address (optional)
  Map<String, dynamic> toJson() => {
        'street': street ?? "",
        'city': city ?? "",
        'province': province ?? "",
        'zipCode': zipCode ?? "",
      };
}
