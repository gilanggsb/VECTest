import 'dart:io';

class UpdateProfileRequestModel {
  final String? name;
  final String? email;
  final String? gender;
  final String? dateOfBirth;
  final String? height;
  final String? weight;
  final String? method;
  final File? profilePicture;

  UpdateProfileRequestModel({
    this.name,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.height,
    this.weight,
    this.method,
    this.profilePicture,
  });

  // Converts the model to a map for the FormData
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'height': height,
      'weight': weight,
      '_method': method,
      'profile_picture': profilePicture,
    };
  }

  // Factory method to create a model from a map
  factory UpdateProfileRequestModel.fromMap(Map<String, dynamic> map) {
    return UpdateProfileRequestModel(
      name: map['name'],
      email: map['email'],
      gender: map['gender'],
      dateOfBirth: map['date_of_birth'],
      height: map['height'],
      weight: map['weight'],
      method: map['_method'],
      profilePicture: map['profile_picture'],
    );
  }
}
