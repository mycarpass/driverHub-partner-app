class PersonName {
  final String name;

  PersonName(this.name);

  String getFirstAndLastName() {
    if (name.split(" ").length > 1) {
      return "${getUserFirstName()} ${getUserLastName()}";
    } else {
      return getUserFirstName();
    }
  }

  String getUserFirstName() {
    return name.split(" ").first;
  }

  String getUserLastName() {
    return name.split(" ").last;
  }
}
