import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_cc/detail_currency_page.dart';

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
    // インスタンスを初期化
    FirebaseAdMob.instance.initialize(appId: getAppId());
    // バナー広告を表示する
    myBanner
      ..load()
      ..show(
        // ボトムからのオフセットで表示位置を決定
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("MY CC"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
        // 最下Listが広告に被らない様にmarginセット
        margin: const EdgeInsets.only(top: 10.0, bottom: 65.0),
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

    final currencyThumbnail = GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailCurrencyPage(currencyId, currencyName)));
        },
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 16.0),
          alignment: FractionalOffset.centerLeft,
          child: new Image(
            image: new AssetImage(imagePath),
            height: 50.0,
            width: 50.0,
          ),
        ));

    final currencyCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(46.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 9.0),
          new Text(currencyName, style: headerTextStyle),
          // new Container(height: 5.0),
          // new Container(
          //     margin: new EdgeInsets.symmetric(vertical: 8.0),
          //     height: 2.0,
          //     width: 18.0,
          //     color: new Color(0xFF867666)),
          // new Text("id: " + currencyId, style: subHeaderTextStyle),
          // // new Container(
          // //     margin: new EdgeInsets.symmetric(vertical: 8.0),
          // //     height: 2.0,
          // //     width: 18.0,
          // //     color: new Color(0xFF867666)),
          // new Row(
          //   children: <Widget>[
          //     // new Expanded(
          //     //     child: _currencyValue(
          //     //         value: "currency.distance", image: imagePath)),
          //     // new Expanded(
          //     //     child: _currencyValue(
          //     //         value: "currency.gravity", image: imagePath))
          //   ],
          // ),
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
          margin: new EdgeInsets.only(left: 27.0),
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
        height: 80.0,
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
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

String getAppId() {
  if (Platform.isIOS) {
    // return BannerAd.testAdUnitId;
    return DotEnv().env["ADMOB_IOS_APPID_MYCC"];
  } else if (Platform.isAndroid) {
    // return BannerAd.testAdUnitId;
    return DotEnv().env["ADMOB_ANDROID_APPID_MYCC"];
  }
  return null;
}

String getBannerId() {
  if (Platform.isIOS) {
    // return BannerAd.testAdUnitId;
    return DotEnv().env["ADMOB_IOS_BANNERID_MYCC"];
  } else if (Platform.isAndroid) {
    // return BannerAd.testAdUnitId;
    return DotEnv().env["ADMOB_ANDROID_BANNERID_MYCC"];
  }
  return null;
}

// 広告ターゲット
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male, // or female, unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // テスト用のIDを使用
  // adUnitId: BannerAd.testAdUnitId,
  // 以下本番用
  adUnitId: getBannerId(),
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    // 広告の読み込みが完了
    // print("BannerAd event is $event");
  },
);
