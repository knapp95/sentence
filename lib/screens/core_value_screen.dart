import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sentence/widgets/animations/animation_widget.dart';
import 'package:sentence/widgets/dialogs/core_add_item_dialog.dart';
import 'package:sentence/widgets/dialogs/core_display_list_dialog.dart';
import 'package:sentence/models/core_value_item_model.dart';
import 'package:sentence/models/core_values_model.dart';
import 'package:sentence/services/localStorage_service.dart';

class CoreValueScreen extends StatefulWidget {
  @override
  _CoreValueScreenState createState() => _CoreValueScreenState();
}

class _CoreValueScreenState extends State<CoreValueScreen> {
  final _random = Random();
  CoreValuesModel _coreValues;
  CoreValueItemModel _displayedCoreValue = CoreValueItemModel();

  void _prepareData() async {
    LocalStorageService.init().then((value) {
      SharedPreferences sharedPreferences = value;
      final coreValuesStr = sharedPreferences.getString('coreValues');

      ///Check coreValues in preferences, if is not defined, initialization from default list.
      if (coreValuesStr != null) {
        _coreValues = CoreValuesModel.fromLocal();
      } else {
        _coreValues = CoreValuesModel.fromDefaultDefined();
        _coreValues.setAllCoreValuesToPreferences();
      }
      _setNewDisplayedCore();
    });
  }

  void _setNewDisplayedCore() {
    setState(() {
      _displayedCoreValue = _coreValues
          .allCoreValues[_random.nextInt(_coreValues.allCoreValuesLength)];
    });
  }

  ///Display selected section for user
  void _openCoreListDialog(int index) {
    String title;
    List<CoreValueItemModel> source;
    switch (index) {
      case 0:
        title = 'All define values';
        source = _coreValues.allCoreValues;
        break;
      case 1:
        title = 'Your favorite quotes';
        source = _coreValues.favoriteCoreValues;
    }
    showDialog<bool>(
      context: context,
      builder: (_) {
        return CoreDisplayListDialog(title, source);
      },
    );
  }

  void _addNewCoreValueDialog() {
    showDialog<bool>(
      context: context,
      builder: (_) {
        return CoreAddItemDialog(_addNewCoreValue);
      },
    );
  }

  void _addNewCoreValue(String sentence) {
    CoreValueItemModel newCoreValueItem =
        CoreValueItemModel(sentence: sentence);
    _coreValues.allCoreValues.add(newCoreValueItem);
    _coreValues.setAllCoreValuesToPreferences();
  }

  void _changeDisplayedIsFavourite() {
    setState(() {
      _displayedCoreValue.isFavourite = !_displayedCoreValue.isFavourite;
    });
    _coreValues.setAllCoreValuesToPreferences();
  }

  @override
  void initState() {
    _prepareData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentence generator'),
        actions: [
          IconButton(
              onPressed: _changeDisplayedIsFavourite,
              icon: Icon(
                _displayedCoreValue.isFavourite
                    ? Icons.favorite_outlined
                    : Icons.favorite_border_outlined,
                color: Colors.white,
              )),
        ],
      ),
      body: AnimationWidget(
        child: Center(
          child: Text(
            _displayedCoreValue.sentence,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Reenie Beanie',
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
        ),
        additionalFunHandler: _setNewDisplayedCore,
        duration: 5000,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _openCoreListDialog,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        items: _buildBottomNavBarItems(),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.format_quote_sharp),
        label: 'Values',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'Favorites',
      ),
    ];
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _addNewCoreValueDialog,
      child: Icon(Icons.add),
    );
  }
}
