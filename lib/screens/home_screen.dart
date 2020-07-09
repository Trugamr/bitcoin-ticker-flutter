import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../constants.dart';
import '../coin_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> getDropdownButton() {
    return DropdownButton<String>(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      dropdownColor: Colors.blue,
      style: TextStyle(
        color: Colors.white,
      ),
      value: selectedCurrency,
      items: currenciesList
          .map((item) => DropdownMenuItem(
                child: Text(item),
                value: item,
              ))
          .toList(),
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
          },
        );
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        print(index);
      },
      children: currenciesList
          .map(
            (item) => Text(
              item,
              style: TextStyle(color: Colors.white),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Ticker'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '1 BTC = ? USD',
                        style: kTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    color: Colors.blue,
                    elevation: 5.0,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12.0),
              color: Colors.blue,
              child: Container(
                child:
                    Platform.isIOS ? getCupertinoPicker() : getDropdownButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
