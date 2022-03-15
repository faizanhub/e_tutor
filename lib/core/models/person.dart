class Person {
  String fullName;
  String email;
  String password;
  String city;
  String address;
  String userType;

  Person({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.city = '',
    this.address = '',
    this.userType = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": this.fullName,
      "email": this.email,
      "city": this.city,
      "address": this.address,
      "userType": this.userType,
    };
  }
}
