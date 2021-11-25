import 'dart:convert';

import 'package:db_sopet/constant.dart';
import 'package:db_sopet/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final int userid = userId;
  List<dynamic> data = [];
  bool finish = false;

  void _getUser(){
    var url = Uri.parse('http://192.168.0.235:3000/getuserandwallet/$userId');
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
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return !finish
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        data[0]['Profile_picture_URL'],
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text(
                      "${data[0]["Firstname_TH"]} ${data[0]["Lastname_TH"]}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/user');
                        },
                        icon: const Icon(Icons.navigate_next))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "ยอดเงิน: ${data[0]['Current_amount']} ฿",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)),
                          bottom: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/topup',
                            arguments:
                                ScreenArguments(data[0]["Wallet_ID"], _getUser));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'เติมเงิน',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)),
                          bottom: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/payment',
                            arguments:
                                ScreenArguments(data[0]["Wallet_ID"], _getUser));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'ประวัติการจ่ายเงิน',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)),
                          bottom: BorderSide(
                              width: 1, color: Colors.black.withOpacity(0.4)))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/service");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'ประวัติแชท',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
