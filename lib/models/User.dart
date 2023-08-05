import 'dart:convert';

import 'package:flutter/cupertino.dart';

//User userJson(dynamic str)=>
//   User.fromJson(json)

class User{
  dynamic _id="";
  dynamic _firstName="";
  dynamic _lastName="";
  dynamic _email="";
  dynamic _city="";
  dynamic _governorate="";
  dynamic _password="";
  dynamic _confirmPassword="";

  User({firstName, lastName, email, governorate, city, password, confirmPassword}){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _city = city;
    _governorate = governorate;
    _password = password;
    _confirmPassword = confirmPassword;
  }

  factory User.fromJson(Map<dynamic, dynamic> json){
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      city: json['city'],
      governorate: json['governorate'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
    );
  }

  dynamic get city => _city;

  set city(dynamic value) {
    _city = value;
  }

  dynamic get email => _email;

  set email(dynamic value) {
    _email = value;
  }

  dynamic get lastName => _lastName;

  set lastName(dynamic value) {
    _lastName = value;
  }

  dynamic get firstName => _firstName;

  set firstName(dynamic value) {
    _firstName = value;
  }

  dynamic get confirmPassword => _confirmPassword;

  set confirmPassword(dynamic value) {
    _confirmPassword = value;
  }

  dynamic get password => _password;

  set password(dynamic value) {
    _password = value;
  }

  dynamic get governorate => _governorate;

  set governorate(dynamic value) {
    _governorate = value;
  }

  dynamic get id => _id;

  set id(dynamic value) {
    _id = value;
  }
}
