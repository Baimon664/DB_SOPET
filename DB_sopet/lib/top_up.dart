import 'package:db_sopet/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TopUp extends StatelessWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    TextEditingController _myController = TextEditingController();
    TextEditingController _myController2 = TextEditingController();
    TextEditingController _myController3 = TextEditingController();
    TextEditingController _myController4 = TextEditingController();
    TextEditingController _myController5 = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("TopUp"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("ยอดเงิน"),
                ),
                // onChanged: (val) => _myController.text = val,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _myController2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("วันที่"),
                ),
                // onChanged: (val) => _myController2.text = val,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _myController3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("เดือน"),
                ),
                // onChanged: (val) => _myController3.text = val,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _myController4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("ปี"),
                ),
                // onChanged: (val) => _myController4.text = val,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _myController5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("เวลา"),
                  hintText: "hh:mm:ss"
                ),
                // onChanged: (val) => _myController5.text = val,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  var date = "${_myController4.text}-${_myController3.text}-${_myController2.text} ${_myController5.text}";
                  var url = Uri.parse('http://192.168.0.235:3000/inserttopupt/${args.walletId}/$date/${_myController.text}');
                  http.get(url).then((value) {
                    args.reload();
                    Navigator.of(context).pop();
                  });
                },
                child: const Text("save",style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ));
  }
}
