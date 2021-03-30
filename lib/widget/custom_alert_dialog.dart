import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title, message, label;
  final Function submit;

  CustomAlertDialog({this.title, this.message, this.label, this.submit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(title, style: TextStyle(color: Theme.of(context).accentColor)),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: submit,
              child: Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: Text(label.toUpperCase(),
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
