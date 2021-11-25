import 'package:db_sopet/message.dart';
import 'package:db_sopet/message_card/own_card.dart';
import 'package:db_sopet/message_card/reply_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String chatroomID;
  const ChatScreen({Key? key, required this.chatroomID}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _isInit = true;
  var _isLoading = false;
  var text = '';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      fetchAndSet(widget.chatroomID).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<Widget> createCard() {
    List<Widget> val = [];
    messageData.forEach((data) {
      if (data.sendertype) {
        val.add(OwnMessageCard(message: data.content, time: data.datetime));
      } else {
        val.add(ReplyCard(message: data.content, time: data.datetime));
      }
    });
    return val;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat History ${widget.chatroomID}"),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(children: createCard())),
    );
  }
}
