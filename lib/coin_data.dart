import 'dart:convert';

import 'package:http/http.dart' as http;

const API_KEY = '36F7F67E-08DE-4D08-BFCA-C39ED930DA5C';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map> getCoinData(String coin) async {
    try {
      var response = await http.get(
          'https://rest.coinapi.io/v1/exchangerate/$coin',
          headers: {'X-CoinAPI-Key': API_KEY});

      var jsonData = jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      throw 'failed to get coin data';
    }
  }
}
