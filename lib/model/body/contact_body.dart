class Contact {
  String? id;
  String? name;
  String? contactNo;
  String? organisation;
  String? email;
  String? address;
  String? note;

  Contact({
    this.id,
    this.name,
    this.contactNo,
    this.organisation,
    this.email,
    this.address,
    this.note,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'contactNo': contactNo,
        'organisation': organisation,
        'email': email,
        'address': address,
        'note': note,
      };
}
