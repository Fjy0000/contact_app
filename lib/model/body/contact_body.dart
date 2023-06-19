import 'dart:convert';

import 'package:app2/main.dart';
import 'package:app2/utils/constants/constant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_body.g.dart';

@JsonSerializable()
class ContactBody {
  DataBean? data;

  ContactBody({this.data});

  factory ContactBody.fromJson(Map<String, dynamic> json) =>
      _$ContactBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ContactBodyToJson(this);
}

@JsonSerializable()
class DataBean {
  List<ContactBean>? contact;

  DataBean({this.contact});

  factory DataBean.fromJson(Map<String, dynamic> json) =>
      _$DataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$DataBeanToJson(this);
}

@JsonSerializable()
class ContactBean {
  String? id;
  String? name;
  String? contactNo;
  String? organisation;
  String? email;
  String? address;
  String? note;
  String? imagePath;

  ContactBean(
      {this.id,
      this.name,
      this.contactNo,
      this.organisation,
      this.email,
      this.address,
      this.note,
      this.imagePath});

  factory ContactBean.fromJson(Map<String, dynamic> json) =>
      _$ContactBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ContactBeanToJson(this);

  // void save() {
  //   box.write(StoreBox.CONTACT, jsonEncode(this));
  // }
  //
  // void remove() {
  //   box.remove(StoreBox.CONTACT);
  // }
  //
  // void read() {
  //   jsonDecode(box.read(StoreBox.CONTACT));
  // }
}
