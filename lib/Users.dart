import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationUserModel{
  final String? name;
  final String? number;
  final String? address;
  final String? email;
  final String? password;
  final String? id;

  OrganizationUserModel({this.id,this.name, this.number, this.address, this.email, this.password});

  static OrganizationUserModel fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot)
  {
    return OrganizationUserModel(
        name: snapshot['name'],
        number: snapshot['number'],
        address: snapshot['address'],
        email: snapshot['email'],
        password: snapshot['password'],
        id: snapshot['id']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "Name": name,
      "Number": number,
      "Address": address,
      "Email": email,
      "Password": password,
      "id": id,
    };
  }
}

