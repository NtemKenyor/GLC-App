extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isNotNull{
    return this!=null;
  }

}


extension StringExtensions on String {
  String get svg => 'assets/$this.svg';
  String get png => 'assets/$this.png';
  String get jpg => 'assets/$this.jpg';
}