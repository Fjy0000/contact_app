import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact_body.g.dart';

@JsonSerializable()
class ContactBody {
  List<ContactBean>? contact;

  ContactBody({this.contact});

  factory ContactBody.fromJson(Map<String, dynamic> json) =>
      _$ContactBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ContactBodyToJson(this);
}

@JsonSerializable()
class ContactBean with ISuspensionBean {
  String? id;
  String? name;
  String? contactNo;
  String? organisation;
  String? email;
  String? address;
  String? note;
  String? imagePath;

  String? get firstLetter {
    if (RegExp(r'[a-zA-Z]').hasMatch(name!)) {
      return name?.substring(0, 1).toUpperCase();
    } else {
      return '#';
    }
  }

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

  @override
  String getSuspensionTag() {
    return firstLetter ?? '';
  }
}
