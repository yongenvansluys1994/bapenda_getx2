class AddressItem {
  final String query;
  final String text;
  AddressItem({required this.query, required this.text});
}

class Address {
  final String provinsi;
  final String kota;
  final String kec;
  final String kel;
  final String address;

  Address({
    required this.provinsi,
    required this.kota,
    required this.kec,
    required this.kel,
    required this.address,
  });
}
