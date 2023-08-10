import 'package:f/models/Reclaim.dart';
import 'package:firedart/firestore/models.dart';
import 'package:f/models/User.dart';

class Answer{
  String _id;
  String _text;
  DateTime _createdAt;
  String _reclaimId;
  String _userName;
  String _userRole;


  factory Answer.fromDoc(Document answer){
    return Answer(answer.id, answer["text"], answer["userName"],answer["userRole"], answer["createdAt"], answer["reclaimId"]);
  }

  Answer(this._id, this._text, this._userName, this._userRole, this._createdAt, this._reclaimId,  );

  String get userRole => _userRole;

  set userRole(String value) {
    _userRole = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get reclaimId => _reclaimId;

  set reclaimId(String value) {
    _reclaimId = value;
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}