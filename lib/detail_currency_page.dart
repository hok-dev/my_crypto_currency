import 'package:flutter/material.dart';
import 'package:my_crypto_currency/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailCurrencyPage extends StatefulWidget {
  final String currencyId;

  DetailCurrencyPage(this.currencyId);

  @override
  _DetailCurrencyPageState createState() =>
      _DetailCurrencyPageState(currencyId);
}

Future<Map> getValue(currencyId) async {
  Map currency = await getCurrency(currencyId);
  return currency;
}

class _DetailCurrencyPageState extends State<DetailCurrencyPage> {
  final String currencyId;
  String currencyName;
  String currencyJpyPrice;

  Future<Map> futureCurrency;
  _DetailCurrencyPageState(this.currencyId);

  // void getValue() async {
  //   Map currency = await getCurrency(currencyId);

  //   currencyName = currency['name'];
  //   currencyJpyPrice = currency[currencyId]['jpy'];
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Detail"),
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: getCurrency(currencyId),
          builder: (context, future) {
            if (!future.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            currencyJpyPrice = future.data[currencyId]['jpy'].toString();
            // currencyJpyPrice = future[currencyId]['jpy'];
            return Center(
              child: Text(currencyJpyPrice),
            );
          },
        )));
  }
}

Future<Map> getCurrency(String currencyId) async {
  Map currencyMap = {};
  String cryptoUrl = "https://api.coingecko.com/api/v3/simple/price?ids=" +
      currencyId +
      "&vs_currencies=jpy";
  http.Response response = await http.get(cryptoUrl);
  currencyMap = jsonDecode(response.body);
  currencyMap['name'] = currencyId;

  return currencyMap;
}
