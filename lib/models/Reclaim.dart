import 'package:f/models/User.dart';
import 'package:firedart/firestore/models.dart';

class Reclaim{

  String _id;
  String _title;
  String _description;
  DateTime _createdAt;
  String _priority;
  List<String> _viewers;
  User _user;

  Reclaim(this._id, this._viewers, this._title, this._description, this._createdAt, this._priority,
      this._user);


  factory Reclaim.fromDoc(Document reclaim){
    return Reclaim(reclaim.id, List.from(reclaim["viewers"]), reclaim["title"], reclaim["description"], reclaim["createdAt"], reclaim["priority"], User(id: reclaim["userId"]));
  }

  User get user => _user;

  set user(User value) {
    _user = value;
  }

  String get priority => _priority;

  set priority(String value) {
    _priority = value;
  }


  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
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

  List<String> get viewers => _viewers;

  set viewers(List<String> value) {
    _viewers = value;
  }
}