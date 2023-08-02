class Equipment{
  String _id;
  String _manufacturer;
  String _model;
  String _PurchaseDate;

  Equipment(this._id ,this._manufacturer, this._model, this._PurchaseDate);

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
}