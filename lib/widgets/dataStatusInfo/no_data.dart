import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              size: 50,
            ),
            Padding(padding: const EdgeInsets.only(top: 8.0)),
            Text('No data my friend.'),
          ],
        ),
      ),
    );
  }
}
