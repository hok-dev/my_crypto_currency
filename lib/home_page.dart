import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_currency/detail_currency_page.dart';

class HomePage extends StatefulWidget {
  final List currencyIdList;
  HomePage(this.currencyIdList);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencyIdList;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Crypto Currency"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
        child: new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            itemCount: widget.currencyIdList.length,
            itemBuilder: (BuildContext context, int index) {
              // final Map currency = widget.currencyIdList[index];
              final String currencyId = widget.currencyIdList[index];
              // final String currencyName = currency['name'];
              // final String currencyJpyPrice =
              //     currency[currencyName]['jpy'].toString();
              final MaterialColor color = _colors[index % _colors.length];
              return _getListItemUi(currencyId, color);
              // return _getListItemUi(currencyName, currencyJpyPrice, color);
            },
          ),
        )
      ],
    ));
  }

  InkWell _getListItemUi(String currencyId, MaterialColor color) {
    return new InkWell(
      child: ListTile(
        leading: new CircleAvatar(
          backgroundColor: color,
          child: new Text(currencyId[0]),
        ),
        title: new Text(currencyId,
            style: new TextStyle(fontWeight: FontWeight.bold)),
        // subtitle: _getSubtitleText(currencyJpyPrice),
        // isThreeLine: true,
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCurrencyPage(currencyId)));
      },
    );
  }

  // Widget _getSubtitleText(String priceJpy) {
  //   TextSpan priceTextWidget = new TextSpan(
  //       text: "\¥$priceJpy\n", style: new TextStyle(color: Colors.black));

  //   return new RichText(text: new TextSpan(children: [priceTextWidget]));
  // }
}
