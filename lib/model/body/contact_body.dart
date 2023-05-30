class Contact {
  String? name;
  String? contactNo;

  Contact({
    this.name,
    this.contactNo,
  });

  Map<String, dynamic> toJson() => {'name': name, 'contactNo': contactNo};

}
