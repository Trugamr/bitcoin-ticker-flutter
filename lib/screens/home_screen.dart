import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:io' show Platform;
import '../constants.dart';
import '../coin_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  String selectedCurrency = 'USD';
  Map btcData, ethData, ltcData;
  String btcRate = '?';
  String ethRate = '?';
  String ltcRate = '?';

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
        updateData(value);
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        updateData(currenciesList[index]);
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

  void updateData(String currency) {
    setState(() {
      btcRate = btcData[currency].toStringAsFixed(2);
      ethRate = ethData[currency].toStringAsFixed(2);
      ltcRate = ltcData[currency].toStringAsFixed(2);
      selectedCurrency = currency;
    });
  }

  void getDataForCoins() async {
    CoinData coinData = CoinData();
    btcData = await coinData.getCoinData('BTC');
    btcData = ratesListToMap(btcData['rates']);

    ethData = await coinData.getCoinData('ETH');
    ethData = ratesListToMap(ethData['rates']);

    ltcData = await coinData.getCoinData('LTC');
    ltcData = ratesListToMap(ltcData['rates']);

    setState(() {
      _isLoading = false;
    });

    updateData('USD');
  }

  Map ratesListToMap(List rates) {
    Map map = {};
    rates.forEach((rate) {
      map[rate['asset_id_quote']] = rate['rate'];
    });
    return map;
  }

  @override
  void initState() {
    super.initState();
    getDataForCoins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin Ticker'),
      ),
      body: LoadingOverlay(
        child: Column(
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
                          '1 BTC = $btcRate $selectedCurrency',
                          style: kTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Colors.blue,
                      elevation: 5.0,
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '1 ETH = $ethRate $selectedCurrency',
                          style: kTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Colors.blue,
                      elevation: 5.0,
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '1 LTC = $ltcRate $selectedCurrency',
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
                  child: Platform.isIOS
                      ? getCupertinoPicker()
                      : getDropdownButton(),
                ),
              ),
            ),
          ],
        ),
        isLoading: _isLoading,
      ),
    );
  }
}
