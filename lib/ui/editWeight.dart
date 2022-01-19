// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/service/database.dart';

class EditWeight extends StatefulWidget {
  final String currentTitle;

  final String documentId;
  const EditWeight({
    this.currentTitle,
    this.documentId,
  });

  @override
  _EditWeightState createState() => _EditWeightState();
}

class _EditWeightState extends State<EditWeight> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  TextEditingController _wieghtController;

  @override
  void initState() {
    _wieghtController = TextEditingController(
      text: widget.currentTitle,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _editItemFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _wieghtController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'weight',
                fillColor: Colors.grey[300],
                filled: true,
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter weight Title';
                }
              },
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              splashColor: Colors.red,
              onPressed: () async {
                if (_editItemFormKey.currentState.validate()) {
                  setState(() {
                    _isProcessing = true;
                  });

                  await Database.updateItem(
                    docId: widget.documentId,
                    weight: _wieghtController.text,
                  );

                  setState(() {
                    _isProcessing = false;
                  });

                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Weight', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
