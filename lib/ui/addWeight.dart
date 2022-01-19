// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:flutter_chat_app/model/weightModel.dart';
import 'package:flutter_chat_app/service/database.dart';
import 'package:provider/provider.dart';

class AddWeight extends StatefulWidget {
  @override
  _AddWeightState createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  final _formKey = GlobalKey<FormState>();

  String weight;
  final TextEditingController _WeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Add Weight'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: _WeightController,
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
                  onSaved: (value) => weight = value),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await Database.addItem(
                      weight: _WeightController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child:
                    Text('Add Weight', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
