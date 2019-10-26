class Driver {
  Driver({this.dataString}) {
    final data = dataString.split(' ');
    this.name = data.first;
  }

  String dataString;
  String name;
}
