import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_currency/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  // List currencies = await getCurrencies();
  List currencies = [];
  const String zny_id = "bitzeny";
  const String mona_id = "monacoin";
  const String alis_id = "alis";
  const String sakura_id = "sakuracoin";
  const String kuma_id = "kumacoin";
  const String fuji_id = "fujicoin";
  const String koto_id = "koto";
  const String bitcoin_id = "bitcoin";
  const String ethereum_id = "ethereum";
  const String xrp_id = "ripple";

  List currencyIdList = [
    zny_id,
    mona_id,
    alis_id,
    sakura_id,
    kuma_id,
    fuji_id,
    koto_id,
    bitcoin_id,
    ethereum_id,
    xrp_id
  ];

  for (var id in currencyIdList) {
    currencies.add(await getCurrency(id));
  }

  print(currencies);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[100]
              : null),
      home: new HomePage(_currencies),
    );
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
