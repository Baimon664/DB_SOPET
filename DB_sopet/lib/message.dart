import 'dart:convert';
import 'package:http/http.dart' as http;

class Message {
  String id;
  bool sendertype;
  String datetime;
  String content;

  Message({
    required this.id,
    required this.sendertype,
    required this.datetime,
    required this.content,
  });
}
List<Message> messageData = [];
const String firebaseurl = 'https://test-65e0e-default-rtdb.asia-southeast1.firebasedatabase.app/sopet/Chatroom_ID/';

Future<void> fetchAndSet(String chatroomID) async {
  final url = Uri.parse(firebaseurl+chatroomID+'.json');
  List<Message> loaded = [];
  try {
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData != null) {
      extractedData.forEach((prodId,prodData) {
        loaded.add(Message(
          id: prodId,
          sendertype: prodData['SenderType'],
          datetime: prodData['DateTime'],
          content: prodData['Content'],
        ));
      });
    }
    messageData = loaded;
  } catch (error) {
    rethrow;
  }
}

Future<void> post(String chatroomID,String datetime, String content, bool sendertype) async {
  final url = Uri.parse(firebaseurl+chatroomID+'.json');
  try {
    final response = await http.post(
      url,
      body: json.encode({
        'Content': content,
        'DateTime': datetime,
        'SenderType': sendertype,
      }),
    );
  } catch (error) {
    rethrow;
  }
}