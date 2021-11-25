import 'dart:convert';

import 'package:db_sopet/constant.dart';
import 'package:db_sopet/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final int userid = userId;
  List<dynamic> data = [];
  bool finish = false;

  void _getUser() {
    var url = Uri.parse('http://192.168.0.235:3000/getuser/$userId');
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

  bool _en = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: !finish
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 60,height: 40,),
                      SizedBox(
                        width: 150,
                        height: 180,
                        child: Image.network(data[0]['Profile_picture_URL'],fit: BoxFit.cover,),
                      ),
                      TextButton(onPressed: () => setState(() {
                        _en=!_en;
                      }), child: _en? const Text("save"): const Text("edit"))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["Firstname_TH"]} ${data[0]["Lastname_TH"]}",
                      label: "ชื่อ",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["Email"]}",
                      label: "อีเมล",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["HouseNumber_Street"]}",
                      label: "บ้านเลขที่-ถนน",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["Subdistrict"]}",
                      label: "แขวง",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["District"]}",
                      label: "เขต",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["Zipcode"]}",
                      label: "รหัสไปรษณี",
                      enable: _en,
                      save: () {}),
                  const SizedBox(height: 20,),
                  CustomTextField(
                      init: "${data[0]["Country"]}",
                      label: "ประเทศ",
                      enable: _en,
                      save: () {}),
                ],
              ),
            ),
          ),
    );
  }
}
