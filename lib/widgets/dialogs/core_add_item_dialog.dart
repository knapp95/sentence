import 'package:flutter/material.dart';

class CoreAddItemDialog extends StatelessWidget {
  final Function coreAddItemHandler;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController valueController = TextEditingController();

  CoreAddItemDialog(this.coreAddItemHandler);

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text('Add new sentence', textAlign: TextAlign.center),
        content: TextFormField(
          controller: valueController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          maxLength: 400,
          validator: (input) => input.isEmpty ? 'Please fill field.' : null,
        ),
        actions: [
          FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop()),
          FlatButton(
            child: Text('Add'),
            onPressed: () {
              if (!_formKey.currentState.validate()) {
                return;
              }
              Navigator.of(context).pop();
              coreAddItemHandler(valueController.text);
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
