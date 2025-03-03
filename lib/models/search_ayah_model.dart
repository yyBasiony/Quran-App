class SearchAyahModel {
  final String text;

  SearchAyahModel({required this.text});

  factory SearchAyahModel.fromText(String ayahText) {
    return SearchAyahModel(text: ayahText);
  }
}
