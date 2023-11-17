import 'dart:collection';

class FipeResponseDto {
  late Map<String, List<FipeHistoryItem>> mapHistory;

  FipeResponseDto.fromJson(Map<String, dynamic> json) {
    mapHistory = HashMap();
    for (var item in json["data"]) {
      String mesRef = item["month"].trim();
      String year = mesRef.substring(mesRef.length - 4);
      if (mapHistory.containsKey(year)) {
        List<FipeHistoryItem> list = mapHistory[year] ?? [];
        list.add(FipeHistoryItem.fromJson(item));
        mapHistory[year] = list;
      } else {
        List<FipeHistoryItem> list = [];
        list.add(FipeHistoryItem.fromJson(item));
        mapHistory[year] = list;
      }
    }
    mapHistory = SplayTreeMap<String, List<FipeHistoryItem>>.from(
        mapHistory, (keys1, keys2) => keys2.compareTo(keys1));

    for (var element in mapHistory.entries) {
      mapHistory[element.key] = element.value.reversed.toList();
    }
  }

  List<Map<String, dynamic>> getGraphicValues() {
    List<Map<String, dynamic>> list = [];
    for (var key in mapHistory.keys) {
      for (FipeHistoryItem history in mapHistory[key] ?? []) {
        Map<String, dynamic> map = {};
        List<String> splited = history.month.trim().split(" ");
        String month = splited[0].substring(0, 3);
        String year = splited[splited.length - 1];
        map["month"] = "$month/$year";
        final numberFormat = double.parse(history.value
            .replaceAll("R\$ ", "")
            .replaceAll(".", "")
            .replaceAll(",", "."));
        map["value"] = numberFormat;
        if (list.length == 6) break;
        list.add(map);
      }
    }
    return list.reversed.toList();
  }

  FipeResponseDto();
}

class FipeHistoryItem {
  late String month;
  late String value;
  late String valueFluctuation;

  FipeHistoryItem(
      {required this.month,
      required this.value,
      required this.valueFluctuation});

  FipeHistoryItem.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    value = json['value'];
    valueFluctuation = json['fipePriceStatus'];
  }
}
