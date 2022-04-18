import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import 'MoneyBox.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExchangeRate.dart';
import 'MoneyBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ExchangeRates? _dataFromAPI;

  @override
  void initState() {
    super.initState();
    getExchangeRate();
  }

  Future<ExchangeRates?> getExchangeRate() async {
    var ratest = "THB";
    var url = "https://api.exchangerate-api.com/v4/latest/"+ratest;
    var response = await http.get(Uri.parse(url));
    _dataFromAPI=exchangeRatesFromJson(response.body);
    return _dataFromAPI;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Exchange Rates"),
        ),
        body: FutureBuilder(
          future: getExchangeRate(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // input data success!
            if(snapshot.connectionState == ConnectionState.done){
              var result = snapshot.data;
              double amount = 100;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  MoneyBox("สกุลเงิน", amount, Colors.lightBlue, 150),
                  const SizedBox(height: 5,),
                  MoneyBox("EUR", amount*result.rates["EUR"], Colors.green, 120),
                  const SizedBox(height: 5,),
                  MoneyBox("USD",amount*result.rates["USD"], Colors.red, 100),
                  const SizedBox(height: 5,),
                  MoneyBox("GBP", amount*result.rates["GBP"], Colors.orange, 100),
                  const SizedBox(height: 5,),
                  MoneyBox("JPY", amount*result.rates["JPY"], Colors.yellow, 100),
                ],),
              );
            }
            return const LinearProgressIndicator();
          },
        ),
        );
  }
}
