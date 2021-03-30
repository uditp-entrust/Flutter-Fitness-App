class AddressModel {
  final String id, userName, phoneNumber, address;

  AddressModel({this.id, this.userName, this.address, this.phoneNumber});

  static List<AddressModel> addressList = [
    AddressModel(
        id: '1',
        userName: 'Juanita Kane',
        phoneNumber: '7735401437',
        address: '4852 Kembery Drive, Chicago II'),
    AddressModel(
        id: '2',
        userName: 'William Roesler',
        phoneNumber: '6157377955',
        address: '2427 Hood Avenue, Kyles Ford, TN'),
  ];
}
