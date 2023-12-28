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

  String getInitialsName() {
    String firstLetter = name.trim().substring(0, 1).toUpperCase();
    String secondLetter = "";
    List<String> nameSplitted = name.trim().split(" ");
    if (nameSplitted.length >= 2) {
      String secondNameSplitted = nameSplitted[nameSplitted.length - 1];
      secondLetter = secondNameSplitted.substring(0, 1).toUpperCase();
    } else {
      secondLetter = name.trim().substring(1, 2).toUpperCase();
    }
    return "$firstLetter$secondLetter";
  }
}
