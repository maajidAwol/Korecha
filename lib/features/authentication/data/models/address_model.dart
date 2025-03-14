import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String id,
    required String fullAddress,
    required bool primary,
    required String phoneNumber,
    required String addressType,
  }) : super(
          id: id,
          fullAddress: fullAddress,
          primary: primary,
          phoneNumber: phoneNumber,
          addressType: addressType,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'].toString(),
      fullAddress: json['fullAddress'],
      primary: json['primary'] ?? false,
      phoneNumber: json['phoneNumber'],
      addressType: json['addressType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullAddress': fullAddress,
      'primary': primary,
      'phoneNumber': phoneNumber,
      'addressType': addressType,
    };
  }
}
