class AddressModel {
  AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.fullName,
    required this.isDefault,
    required this.phoneNumber,
    required this.postalCode,
    required this.state,
  });
  late final String addressLine1;
  late final String addressLine2;
  late final String city;
  late final String country;
  late final String fullName;
  late final bool isDefault;
  late final String phoneNumber;
  late final String postalCode;
  late final String state;

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    city = json['city'];
    country = json['country'];
    fullName = json['fullName'];
    isDefault = json['isDefault'];
    phoneNumber = json['phoneNumber'];
    postalCode = json['postalCode'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['addressLine1'] = addressLine1;
    data['addressLine2'] = addressLine2;
    data['city'] = city;
    data['country'] = country;
    data['fullName'] = fullName;
    data['isDefault'] = isDefault;
    data['phoneNumber'] = phoneNumber;
    data['postalCode'] = postalCode;
    data['state'] = state;
    return data;
  }
}
