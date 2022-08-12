class UpdateTeacher {
  String fullName;
  String city;
  String address;
  String subjects;
  String experience;

  UpdateTeacher({
    this.fullName = '',
    this.city = '',
    this.address = '',
    this.subjects = '',
    this.experience = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "city": city,
      "address": address,
      "subjects": subjects,
      "experience": experience,
    };
  }
}
