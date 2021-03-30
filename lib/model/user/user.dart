import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String password;
  String phoneNumber;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber});
}
