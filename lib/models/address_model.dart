class Address {
  final String id; // Unique identifier for the address
  final String userId; // User ID associated with the address
  final String fullName; // Full name of the user
  final String addressLine1; // Primary address line
  final String addressLine2; // Secondary address line (optional)
  final String city; // City name
  final String state; // State or province
  final String postalCode; // Postal or ZIP code
  final String country; // Country name
  final String phoneNumber; // Contact number
  final bool isDefault; // Indicates if this is the default address

  Address({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.addressLine1,
    this.addressLine2 = '',
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'phoneNumber': phoneNumber,
      'isDefault': isDefault,
    };
  }
}
