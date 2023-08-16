import 'package:f/enums/printer_type.dart';
import 'package:f/models/Equipment.dart';

class Printer extends Equipment{
  PrinterType _type;
  List<String> _functions;
  String _resolution;
  String _monoPrintSpeed;
  String _colourPrintSpeed;
  //PHYSICAL FEATURES
  String _dimensions;
  String _weight;

  Printer(super._id,super._userId,super._status,super._manufacturer,super._model,super._PurchaseDate,this._type, this._functions, this._resolution, this._monoPrintSpeed,
      this._colourPrintSpeed, this._dimensions, this._weight);

  String get weight => _weight;

  set weight(String value) {
    _weight = value;
  }

  String get dimensions => _dimensions;

  set dimensions(String value) {
    _dimensions = value;
  }

  String get colourPrintSpeed => _colourPrintSpeed;

  set colourPrintSpeed(String value) {
    _colourPrintSpeed = value;
  }

  String get monoPrintSpeed => _monoPrintSpeed;

  set monoPrintSpeed(String value) {
    _monoPrintSpeed = value;
  }

  String get resolution => _resolution;

  set resolution(String value) {
    _resolution = value;
  }

  List<String> get functions => _functions;

  set functions(List<String> value) {
    _functions = value;
  }

  PrinterType get type => _type;

  set type(PrinterType value) {
    _type = value;
  }
}