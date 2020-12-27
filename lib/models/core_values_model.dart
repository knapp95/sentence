import 'dart:convert';
import 'package:sentence/models/core_value_item_model.dart';
import 'package:sentence/services/localStorage_service.dart';

class CoreValuesModel {
  /// CONSTRUCTORS
  CoreValuesModel();

  CoreValuesModel.fromDefaultDefined() {
    this.allCoreValues = defaultCoreValues;
  }

  CoreValuesModel.fromLocal() {
    this.allCoreValues =  this.getAllCoreValuesFromPreferences();
  }

  ///FIELDS
  List<CoreValueItemModel> _allCoreValues = [];

  static const List<String> _defaultCoreValues = [
    'Exceed clients\' and colleagues\' expectations',
    'Take ownership and question the status quo in a constructive manner',
    'Be brave, curious and experiment. Learn from all successes and failures',
    'Act in a way that makes all of us proud',
    'Build an inclusive, transparent and socially responsible culture',
    'Be ambitious, grow yourself and the people around you',
    'Recognize excellence and engagement',
  ];


  List<CoreValueItemModel> getAllCoreValuesFromPreferences() {
    List<CoreValueItemModel> allCoreValues = [];
    try {
      final coreValuesStr = LocalStorageService.getString('coreValues');
      if (coreValuesStr != null) {
        List<dynamic> coreValuesList =
        jsonDecode(coreValuesStr) as List<dynamic>;
        if (coreValuesList != null) {
          for (dynamic coreValueJson in coreValuesList) {
            CoreValueItemModel coreValueItemTmp =
            CoreValueItemModel.fromJson(coreValueJson);
            allCoreValues.add(coreValueItemTmp);
          }
        }
      }
    } catch (error) {
      throw error;
    }
    return allCoreValues;
  }

  void setAllCoreValuesToPreferences() {
    try {
      if (this.allCoreValues != null) {
        var coreValueList = List();
        this..allCoreValues.forEach((coreValue) {
          coreValueList.add(coreValue.toJson());
        });
        LocalStorageService.setString('coreValues', jsonEncode(coreValueList));
      }
    } catch (error) {
      throw error;
    }
  }

  ///GETTERS && SETTERS

  List<CoreValueItemModel> get defaultCoreValues {
    List<CoreValueItemModel> defaultCoreValues = [];
    _defaultCoreValues.forEach((element) => defaultCoreValues.add(
          CoreValueItemModel(sentence: element),
        ));
    return defaultCoreValues;
  }

  ///Get from source list only selected as favourite
  List<CoreValueItemModel> get favoriteCoreValues =>
      this.allCoreValues.where((element) => element.isFavourite).toList();

  List<CoreValueItemModel> get allCoreValues => this._allCoreValues;

  set allCoreValues(List<CoreValueItemModel> value) =>
      this._allCoreValues = value;

  int get allCoreValuesLength => this.allCoreValues.length;
}
