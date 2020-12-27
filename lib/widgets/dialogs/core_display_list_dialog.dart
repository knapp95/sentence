import 'package:flutter/material.dart';
import 'package:sentence/models/core_value_item_model.dart';
import 'package:sentence/widgets/dataStatusInfo/no_data.dart';

class CoreDisplayListDialog extends StatelessWidget {
  final String title;
  final List<CoreValueItemModel> coreValues;

  CoreDisplayListDialog(this.title, this.coreValues);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: coreValues.isEmpty
          ? NoData()
          : Container(
              width: double.maxFinite,
              child: ListView.separated(
                itemBuilder: (_, int index) {
                  CoreValueItemModel coreValueItem = this.coreValues[index];
                  return ListTile(
                    leading: coreValueItem.isFavourite
                        ? _buildIconIsFavourite()
                        : _buildIconIsNotFavourite(),
                    title: Text('"${coreValueItem.sentence}"'),
                  );
                },
                separatorBuilder: (_, __) {
                  return Divider();
                },
                itemCount: this.coreValues.length,
              ),
            ),
      actions: [
        FlatButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );
  }

  Widget _buildIconIsFavourite() {
    return Icon(
      Icons.favorite_outlined,
      color: Colors.red,
    );
  }

  Widget _buildIconIsNotFavourite() {
    return Icon(
      Icons.favorite_border_outlined,
      color: Colors.grey,
    );
  }
}
