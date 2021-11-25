import 'package:db_sopet/chat_screen.dart';
import 'package:db_sopet/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  List<dynamic> data = [];
  bool finish = false;
  void _getServiceHistory() {
    var url = Uri.parse('http://192.168.0.235:3000/getservice/$userId');
    http.get(url).then((res) {
      setState(() {
        var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as List;
        data = decodedResponse[0];
        print(data);
        finish = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getServiceHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat History"),
      ),
      body: !finish
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, idx) => ChatHistoryCard(vetName: data[idx]['Vet_name'].toString(), chatroomID: data[idx]['chatroom_id'].toString()),
              ),
          ),
    );
  }
}

class ChatHistoryCard extends StatelessWidget {
  final String vetName;
  final String chatroomID;
  const ChatHistoryCard({Key? key, required this.vetName, required this.chatroomID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(chatroomID: chatroomID)));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black,width: 1.5),
            borderRadius: BorderRadius.circular(10)
          ),
          height: 100,
          width: 200,
          child: Center(child: Text(vetName,style: const TextStyle(fontSize: 20),),),
        ),
      ),
    );
  }
}

