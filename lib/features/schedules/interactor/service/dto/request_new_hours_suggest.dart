class RequestNewHoursSuggest {
  List<NewHourSuggestion> newDateSuggestions = [];

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> suggestions = [];
    for (var suggs in newDateSuggestions) {
      suggestions.add(NewHourSuggestion(
              date: suggs.date, timeSuggestion: suggs.timeSuggestion)
          .toJson());
    }
    return {"new_date_suggestions": suggestions};
  }
}

class NewHourSuggestion {
  String date;
  String timeSuggestion;

  NewHourSuggestion({required this.date, required this.timeSuggestion});

  Map<String, dynamic> toJson() {
    return {"date": date, "time_suggestion": timeSuggestion};
  }
}
