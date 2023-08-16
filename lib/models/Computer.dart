import 'package:f/models/Equipment.dart';
import 'package:firedart/firestore/models.dart';

class Computer extends Equipment {
  String _operatorSystem;
  String _processeur;
  String _randomAccessMemory;
  String _graphicCards;
  String _physicalMemory;

  Computer(super._id, super._status, super._userId, super._manufacturer,super._model,super._PurchaseDate,this._graphicCards, this._operatorSystem,this._processeur, this._randomAccessMemory, this._physicalMemory);

  String get physicalMemory => _physicalMemory;

  set physicalMemory(String value) {
    _physicalMemory = value;
  }

  String get randomAccessMemory => _randomAccessMemory;

  set randomAccessMemory(String value) {
    _randomAccessMemory = value;
  }

  String get processeur => _processeur;

  set processeur(String value) {
    _processeur = value;
  }

  static fromMap(Page<Document> map) {}

  String get operatorSystem => _operatorSystem;

  set operatorSystem(String value) {
    _operatorSystem = value;
  }

  String get graphicCards => _graphicCards;

  set graphicCards(String value) {
    _graphicCards = value;
  }
}
