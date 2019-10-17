import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
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
            itemCount: widget.currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencies[index];
              final String currencyName = currency['name'];
              final String currencyJpyPrice =
                  currency[currencyName]['jpy'].toString();
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUi(currencyName, currencyJpyPrice, color);
            },
          ),
        )
      ],
    ));
  }

  ListTile _getListItemUi(
      String currencyName, String currencyJpyPrice, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currencyName[0]),
      ),
      title: new Text(currencyName,
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(currencyJpyPrice),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceJpy) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\¥$priceJpy\n", style: new TextStyle(color: Colors.black));

    return new RichText(text: new TextSpan(children: [priceTextWidget]));
  }
}
