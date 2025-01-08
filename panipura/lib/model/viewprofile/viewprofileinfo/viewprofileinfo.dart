import '../viewxtraskillist/viewxtraskillist.dart';
import 'dart:developer';

class ViewprofileInfo {
  final int? id;
  final String? name;
  final String? address;
  final String? place;
  final String? post;
  final String? pin;
  final int? genderid;
  final String? gendername;
  final int? districtid;
  final String? disname;
  final int? blockid;
  final String? localtypename;
  final int? localbodyid;
  final String? localname;
  final String? dob;
  final String? aadhaar;
  final String? mobile;
  final int? educationid;
  final String? eduname;
  final String? updatedat;
  List<Viewxtraskillist> skills;

  ViewprofileInfo({
    this.id,
    this.name,
    this.address,
    this.place,
    this.post,
    this.pin,
    this.genderid,
    this.gendername,
    this.districtid,
    this.disname,
    this.blockid,
    this.localtypename,
    this.localbodyid,
    this.localname,
    this.dob,
    this.aadhaar,
    this.mobile,
    this.educationid,
    this.eduname,
    this.updatedat,
    this.skills = const [],
  });
  factory ViewprofileInfo.fromJson(Map<String, dynamic> json) {
    var list = json["skills"] as List;
    log('${list.runtimeType}');
    List<Viewxtraskillist> searchlist =
        list.map((e) => Viewxtraskillist.fromJson(e)).toList();
    return ViewprofileInfo(
        id: json['id'],
        name: json['name'],
        address: json['address'],
        place: json['place'],
        post: json['post'],
        pin: json['pin'],
        genderid: json['gender_id'],
        gendername: json['gender_name'],
        districtid: json['district_id'],
        disname: json['district_name'],
        blockid: json['block_id'],
        localtypename: json['localbody_types_name'],
        localbodyid: json['localbody_id'],
        localname: json['localbody_name'],
        dob: json['dob'],
        aadhaar: json['aadhaar'],
        mobile: json['mobile'],
        educationid: json['education_id'],
        eduname: json['education_name'],
        updatedat: json['updated_at'],
        skills: searchlist);
  }
}
