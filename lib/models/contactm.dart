class ContactM {

  int? id;
  String? name;
  String? email;
  String? uuid;
  String? phoneNo;
  String? status;
  String? profileImage;

  ContactM(
  {this.id,
  this.name,
  this.email,
  this.uuid,
  this.phoneNo,
  this.status,
  this.profileImage});

  ContactM.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  email = json['email'];
  uuid = json['uuid'];
  phoneNo = json['phone_no'];
  status = json['status'];
  profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  data['email'] = this.email;
  data['uuid'] = this.uuid;
  data['phone_no'] = this.phoneNo;
  data['status'] = this.status;
  data['profile_image'] = this.profileImage;
  return data;
  }

}

