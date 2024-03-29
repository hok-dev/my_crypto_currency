import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Androidで挙動不良起動せず一旦コメントアウト
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCurrencyPage extends StatefulWidget {
  final String currencyId;
  final String currencyName;

  DetailCurrencyPage(this.currencyId, this.currencyName);

  @override
  _DetailCurrencyPageState createState() =>
      _DetailCurrencyPageState(currencyId, currencyName);
}

class _DetailCurrencyPageState extends State<DetailCurrencyPage> {
  final fromTextController = TextEditingController(text: '1');
  final String currencyId;
  final String currencyName;
  Map currencyMap = {};
  List<String> currencies;
  String result;
  String fromCurrency = "";
  List<String> currenciesList = ["JPY", "USD", "EUR"];
  final String prefCatCurrency = 'Currency';

  Future<Map> futureCurrency;
  _DetailCurrencyPageState(this.currencyId, this.currencyName);

  @override
  void initState() {
    super.initState();
    _getInitCurrencyPrefStr();
    // _loadCurrencies(this.currencyId);
  }

  // Currency設定, by SharedPreferences
  _setCurrency(String currency) async {
    setState(() {
      _setPref(prefCatCurrency, currency);
    });
    _getCurrency();
  }

  // Currency取得, by SharedPreferences
  _getCurrency() {
    _getPrefStr(prefCatCurrency);
  }

  // SharedPreferences操作, 設定
  _setPref(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
    return value;
  }

  // SharedPreferences操作, 取得
  Future<Null> _getPrefStr(String key) async {
    String prefValue;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      prefValue = pref.getString(key) ?? '';
      // parameterがCurrencyの場合
      if (key == prefCatCurrency) {
        if (prefValue == '') {
          fromCurrency = "JPY";
        } else {
          fromCurrency = prefValue;
        }
      }
    });
  }

  // Init時Currency取得 SharedPreferences操作, 取得
  Future<Null> _getInitCurrencyPrefStr() async {
    String prefValue;
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      prefValue = pref.getString(prefCatCurrency) ?? '';
      if (prefValue == '') {
        fromCurrency = "JPY";
      } else {
        fromCurrency = prefValue;
      }
    });

    _loadCurrencies(this.currencyId);
  }

  Future<String> _loadCurrencies(String currencyId) async {
    try {
      String cryptoUrl = "https://api.coingecko.com/api/v3/simple/price?ids=" +
          currencyId +
          "&vs_currencies=" +
          fromCurrency;
      http.Response response = await http.get(cryptoUrl);
      currencyMap = jsonDecode(response.body);
      currencies = currencyMap.keys.toList();
      if (fromCurrency == "JPY") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["jpy"]))
              .toString();
        });
      } else if (fromCurrency == "USD") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["usd"]))
              .toString();
        });
      } else if (fromCurrency == "EUR") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["eur"]))
              .toString();
        });
      }

      // setState(() {});
      // print("_loadCurrencies" + result);
      return "Success";
    } catch (e) {
      result = "API connection error";
      print("_loadCurrencies error");
      return "Failure";
    }
  }

  Future<String> _doConversion(String currencyId) async {
    try {
      String cryptoUrl = "https://api.coingecko.com/api/v3/simple/price?ids=" +
          currencyId +
          "&vs_currencies=" +
          fromCurrency;
      http.Response response = await http.get(cryptoUrl);
      currencyMap = jsonDecode(response.body);
      if (fromCurrency == "JPY") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["jpy"]))
              .toString();
        });
      } else if (fromCurrency == "USD") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["usd"]))
              .toString();
        });
      } else if (fromCurrency == "EUR") {
        setState(() {
          result = (double.parse(fromTextController.text) *
                  (currencyMap[currencyId]["eur"]))
              .toString();
        });
      }

      // print("_doConversion" + result);
      return result;
    } catch (e) {
      result = "API connection error";
      print("_loadCurrencies error");
      return result;
    }
  }

  _onFromChanged(String value) {
    _setCurrency(value);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(currencyName + " Converter"),
      ),
      resizeToAvoidBottomInset: false,
      body: currencies == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 3.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          currencyName,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                      ListTile(
                        title: TextField(
                          controller: fromTextController,
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          // onEditingComplete: () {
                          //   _doConversion(this.currencyId);
                          // },
                        ),
                        trailing: _buildDropDownButton(fromCurrency),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 50.0,
                        onPressed: () {
                          _doConversion(this.currencyId).then((result) {
                            Clipboard.setData(new ClipboardData(text: result));
                            // Androidで挙動不良起動せず一旦コメントアウト
                            // Fluttertoast.showToast(
                            //     msg: "Clipboard Copied",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.TOP,
                            //     // timeInSecForIos: 1,
                            //     backgroundColor: Colors.grey,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0);
                          });
                        },
                      ),
                      ListTile(
                        title: Chip(
                          label: result != null
                              ? Text(
                                  result,
                                  style: Theme.of(context).textTheme.display1,
                                )
                              : Text(""),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Copy the after convert currency to the clipboard",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currenciesList
          .map((String value) => DropdownMenuItem(
                value: value,
                child: Row(
                  children: <Widget>[
                    Text(value),
                  ],
                ),
              ))
          .toList(),
      onChanged: (String value) {
        if (currencyCategory == fromCurrency) {
          _onFromChanged(value);
          // _doConversion(this.currencyId);
        }
      },
    );
  }
}
