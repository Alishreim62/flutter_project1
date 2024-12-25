class Expense {
  final String _type;
  final String _name;
  final double _amount;
  var _time;

  Expense(this._type, this._name, this._amount) {
    _time = DateTime.now();
  }

  String get type => _type;

  String get name => _name;

  double get amount => _amount;

  String get time {
    return _time.toString();
  }

  @override
  String toString() {

    return '$type: $name, amount: $amount, time: $time';
  }
}