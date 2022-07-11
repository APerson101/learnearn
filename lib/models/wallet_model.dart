import 'dart:convert';

class Wallet {
  String address;
  String private_key;
  String public_key;
  Wallet({
    required this.address,
    required this.private_key,
    required this.public_key,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'private_key': private_key,
      'public_key': public_key,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      address: map['address'] ?? '',
      private_key: map['private_key'] ?? '',
      public_key: map['public_key'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) => Wallet.fromMap(json.decode(source));

  @override
  String toString() =>
      'Wallet(address: $address, private_key: $private_key, public_key: $public_key)';
}
