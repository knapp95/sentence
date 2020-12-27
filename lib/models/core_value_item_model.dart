class CoreValueItemModel {

  CoreValueItemModel({sentence = ''}) {
    this.sentence = sentence;
  }

  ///FIELDS
  String _sentence;
  bool _isFavourite = false;

  ///JSON
  CoreValueItemModel.fromJson(Map<String, dynamic> json) {
    this.sentence = json['sentence'];
    this.isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sentence'] = this.sentence;
    data['isFavourite'] = this.isFavourite;
    return data;
  }

  /// GETTERS && SETTERS

  bool get isFavourite => _isFavourite;

  set isFavourite(bool value) => this._isFavourite = value;

  String get sentence => _sentence;

  set sentence(String value) => this._sentence = value;
}
