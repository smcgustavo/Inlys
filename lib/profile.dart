class Profile {
  static String _name = "Gustavo";
  static late double _selic;

  Profile(String name, double selic){
    _name = name;
    _selic = selic;
  }

  static set setName(String value) {
    _name = value;
  }

  String get name => _name;
  double get selic => _selic;

  void setSelic(double value){
    _selic = value;
  }

}