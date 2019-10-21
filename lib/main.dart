import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_currency/home_page.dart';

void main() async {
  const String zny_id = "bitzeny";
  const String mona_id = "monacoin";
  const String alis_id = "alis";
  const String sakura_id = "sakuracoin";
  const String kuma_id = "kumacoin";
  const String fuji_id = "fujicoin";
  const String koto_id = "koto";
  const String btc_id = "bitcoin";
  const String eth_id = "ethereum";
  const String xrp_id = "ripple";

  Map znyMap = {
    'id': zny_id,
    'name': "BitZeny (ZNY)",
    'url': "https://bitzeny.tech/",
    'image': "assets/coins/zny.png"
  };
  Map monaMap = {
    'id': mona_id,
    'name': "MonaCoin (MONA)",
    'url': "https://monacoin.org/",
    'image': "assets/coins/mona.png"
  };
  Map alisMap = {
    'id': alis_id,
    'name': "ALIS (ALIS)",
    'url': "https://alismedia.jp/",
    'image': "assets/coins/alis.png"
  };
  Map sakuraMap = {
    'id': sakura_id,
    'name': "Sakuracoin (SKR)",
    'url': "https://twitter.com/sakuracoin",
    'image': "assets/coins/sakura.png"
  };
  Map kumaMap = {
    'id': kuma_id,
    'name': "KumaCoin (KUMA)",
    'url': "https://kumacoinproject.github.io/kumacoin/",
    'image': "assets/coins/kuma.png"
  };
  Map fujiMap = {
    'id': fuji_id,
    'name': "Fujicoin (FJC)",
    'url': "http://www.fujicoin.org/",
    'image': "assets/coins/fuji.png"
  };
  Map kotoMap = {
    'id': koto_id,
    'name': "Koto (KOTO)",
    'url': "https://ko-to.org/",
    'image': "assets/coins/koto.png"
  };
  Map btcMap = {
    'id': btc_id,
    'name': "Bitcoin (BTC)",
    'url': "https://bitcoin.org/",
    'image': "assets/coins/btc.png"
  };
  Map ethMap = {
    'id': eth_id,
    'name': "Ethereum (ETH)",
    'url': "https://www.ethereum.org/",
    'image': "assets/coins/eth.png"
  };
  Map xrpMap = {
    'id': xrp_id,
    'name': "XRP (XRP)",
    'url': "https://www.ripple.com/xrp/",
    'image': "assets/coins/xrp.png"
  };

  List currencyList = [
    btcMap,
    ethMap,
    xrpMap,
    znyMap,
    monaMap,
    alisMap,
    sakuraMap,
    kumaMap,
    fujiMap,
    kotoMap,
  ];

  runApp(new MyApp(currencyList));
}

class MyApp extends StatelessWidget {
  final List currencyList;
  MyApp(this.currencyList);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Color(0xFFE1B80D)
              // ? Colors.grey[300]
              : Color(0xFFE1B80D)),
      home: new HomePage(currencyList),
    );
  }
}
