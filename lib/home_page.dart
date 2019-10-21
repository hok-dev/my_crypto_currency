import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_currency/detail_currency_page.dart';

class HomePage extends StatefulWidget {
  final List currencyList;
  HomePage(this.currencyList);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencyList;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Cryptocurrency Converter"),
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
            itemCount: widget.currencyList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget.currencyList[index];

              return _getListItemUi(currency['id'], currency['name'],
                  currency['url'], currency['image']);
            },
          ),
        )
      ],
    ));
  }

  Container _getListItemUi(
      String currencyId, String currencyName, String url, String imagePath) {
    final currencyThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Image(
        image: new AssetImage(imagePath),
        height: 80.0,
        width: 80.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400);
    final subHeaderTextStyle = regularTextStyle.copyWith(fontSize: 12.0);
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w600);

    Widget _currencyValue({String value, String image}) {
      return new Row(children: <Widget>[
        new Image.asset(image, height: 12.0),
        new Container(width: 8.0),
        new Text(url, style: regularTextStyle),
      ]);
    }

    final currencyCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(currencyName, style: headerTextStyle),
          new Container(height: 5.0),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xFF867666)),
          new Text("id: " + currencyId, style: subHeaderTextStyle),
          // new Container(
          //     margin: new EdgeInsets.symmetric(vertical: 8.0),
          //     height: 2.0,
          //     width: 18.0,
          //     color: new Color(0xFF867666)),
          new Row(
            children: <Widget>[
              // new Expanded(
              //     child: _currencyValue(
              //         value: "currency.distance", image: imagePath)),
              // new Expanded(
              //     child: _currencyValue(
              //         value: "currency.gravity", image: imagePath))
            ],
          ),
        ],
      ),
    );

    final currencyCard = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailCurrencyPage(currencyId, currencyName)));
        },
        child: new Container(
          child: currencyCardContent,
          height: 112.0,
          margin: new EdgeInsets.only(left: 38.0),
          decoration: new BoxDecoration(
            color: new Color(0xFFEAE2D6),
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
        ));

    return new Container(
        height: 116.0,
        margin: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            currencyCard,
            currencyThumbnail,
          ],
        ));
  }
}
