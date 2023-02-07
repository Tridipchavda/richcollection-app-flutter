
class CustomerModel{
  String? email;
  String? phone;
  String? pass;
  String? address;
  String? city;
  String? pincode;
  String? age;
  String? gender;
  String? name;

  CustomerModel({this.email,this.name,this.age,this.pass,this.gender,this.address,this.city,this.pincode});

  factory CustomerModel.fromMap(map){
    return CustomerModel(
        email: map['email'],
        name: map['name'],
        age: map['age'],
        pass: map["pass"],
        gender: map["gender"],
        address: map["address"],
        city: map["city"],
        pincode: map["pincode"]
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'email': email,
      'name': name,
      'age': age,
      'pass': pass,
      'gender': gender,
      'address': address,
      'city': city,
      'pincode': pincode,
    };
  }
}