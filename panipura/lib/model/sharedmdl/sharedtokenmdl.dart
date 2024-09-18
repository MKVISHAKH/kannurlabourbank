class SharedtokenM {
  late int? userid;
  late String? token;
  late String? name;
  late String? mobile;
  late String? address;
  late String? place;
  late String? post;
  late String? pin;
  late String? gender;
  late int? genderId;
  late String? district;
  late int? distId;
  late String? block;
  late int? blockId;
  late String? localbody;
  late int? localbodyId;
  late String? dob;
  late String? aadhaar;
  late String? education;
  late int? educationId;
  late int? category;
  late String? password;
  //late String? cPassword;

  SharedtokenM({
    this.userid,
    this.token,
    this.name,
    this.mobile,
    this.address,
    this.place,
    this.post,
    this.pin,
    this.gender,
    this.genderId,
    this.district,
    this.distId,
    this.block,
    this.blockId,
    this.localbody,
    this.localbodyId,
    this.dob,
    this.aadhaar,
    this.education,
    this.educationId,
    this.category,
    this.password,
    //this.education,
  });

  SharedtokenM.values(
      {required this.userid,
      required this.token,
      required this.name,
      required this.mobile,
      this.address,
      this.place,
      this.post,
      this.pin,
      this.gender,
      this.genderId,
      this.district,
      this.distId,
      this.block,
      this.blockId,
      this.localbody,
      this.localbodyId,
      this.dob,
      this.aadhaar,
      this.education,
      this.educationId,
      this.category,
      this.password});

  factory SharedtokenM.fromJson(Map<String, dynamic> json) {
    return SharedtokenM(
      token: json['token'],
      name: json['name'],
      mobile: json['mobile'],
      address: json['address'],
      place: json['place'],
      post: json['post'],
      pin: json['pin'],
      gender: json['gender'],
      genderId: json['genderId'],
      district: json['district'],
      distId: json['districtId'],
      block: json['block'],
      blockId: json['blockId'],
      localbody: json['localbody'],
      localbodyId: json['localbodyId'],
      dob: json['dob'],
      aadhaar: json['aadhaar'],
      education: json['education'],
      educationId: json['edicationId'],
      category: json['category'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "mobile": mobile,
        "address": address,
        "place": place,
        "post": post,
        "pin": pin,
        "gender": gender,
        "genderId": genderId,
        "district": district,
        "districtId": distId,
        "block": block,
        "blockId": blockId,
        "localbody": localbody,
        "localbodyId": localbodyId,
        "dob": dob,
        "aadhaar": aadhaar,
        "education": education,
        "educationId": educationId,
        "category": category,
        "password": password,
      };
}
