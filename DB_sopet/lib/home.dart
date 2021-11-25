import 'dart:convert';

import 'package:db_sopet/setting.dart';
import 'package:db_sopet/vet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<Widget> _page = [Homepage(),Setting()];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("SOPET DEMO"),
        ),
        body: _page[index],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "profile")
          ],
          currentIndex: index,
          onTap: (idx) => setState(() {
            index = idx;
          }),
        ),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<dynamic> vet = [];
  bool finish = false;

  void _getVet() async {
      var url = Uri.parse('http://192.168.0.235:3000/getvet');
      http.get(url).then((res) {
        setState(() {
          var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as List;
          vet = decodedResponse;
          finish = true;
        });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getVet();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (finish == false) const CircularProgressIndicator(),
          if (finish)
            Expanded(
              child: ListView.builder(
                  itemCount: vet.length,
                  itemBuilder: (ctx, idx) => Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Vet(data: vet[idx]),
                      )),
            ),
        ],
      ),
    );
  }
}
