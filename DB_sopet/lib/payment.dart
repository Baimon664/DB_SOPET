import 'dart:convert';

import 'package:db_sopet/constant.dart';
import 'package:db_sopet/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final int userid = userId;
  List<dynamic> data = [];
  bool finish = false;

  void _getPayment() {
    setState(() {
      finish = false;
    });
    var url = Uri.parse('http://192.168.0.235:3000/getpayment/$userId');
    http.get(url).then((res) {
      setState(() {
        var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as List;
        data = decodedResponse;
        finish = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPayment();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ประวัติการชำระเงิน"),
      ),
      body: !finish
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, idx) => HistoryCard(
                date: data[idx]['Payment_history_datetime'].toString(),
                amount: data[idx]['Payment_history_amount'].toString(),
                wallet_id: int.parse(data[idx]['Wallet_ID'].toString()),
                reload: _getPayment,
                reload2: args.reload,
              ),
            ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final int wallet_id;
  final String date;
  final String amount;
  final Function reload;
  final Function reload2;
  const HistoryCard(
      {Key? key,
      required this.date,
      required this.amount,
      required this.wallet_id,
      required this.reload,
      required this.reload2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var db = MySql();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(15),
        ),
        height: 100,
        width: 100,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.substring(0, 19),
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    amount,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  var dateti = "${date.substring(0, 10)} ${int.parse(date.substring(11, 13))+7}${date.substring(13,19)}";
                  print(dateti);
                  var url = Uri.parse('http://192.168.0.235:3000/deletepayment/$wallet_id/${dateti}/$amount');
                  http.get(url).then((value) {
                    print("reload");
                    reload();
                    reload2();
                  });
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
