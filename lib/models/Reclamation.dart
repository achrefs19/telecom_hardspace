import 'package:f/models/User.dart';

class Reclamation{

  String _id;
  String _title;
  String _description;
  String _createdAt;
  String _priority;
  User _user;

  Reclamation(this._id, this._title, this._description, this._createdAt, this._priority,
      this._user);

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  String get priority => _priority;

  set priority(String value) {
    _priority = value;
  }

  String get createdAt => _createdAt;

  set createdAt(String value) {
    _createdAt = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}