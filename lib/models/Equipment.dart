class Equipment{
  String _id;
  String _manufacturer;
  String _model;
  String _PurchaseDate;
  String _userId;
  String _status;

  Equipment(this._userId, this._status, this._id ,this._manufacturer, this._model, this._PurchaseDate);

  String get PurchaseDate => _PurchaseDate;

  set PurchaseDate(String value) {
    _PurchaseDate = value;
  }

  String get model => _model;

  set model(String value) {
    _model = value;
  }

  String get manufacturer => _manufacturer;

  set manufacturer(String value) {
    _manufacturer = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }
}