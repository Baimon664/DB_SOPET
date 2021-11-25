import 'package:flutter/material.dart';

class Vet extends StatelessWidget {
  final Map<String, dynamic> data;
  const Vet({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black12
      ),
      height: 200,
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: 150,
              child: Image.network(
                data['Profile_picture_URL'].toString(),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data['Firstname_TH']} ${data['Lastname_TH']}",style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 20,),
                Text(data['ProfessionalLicense_ID'].toString(),style: const TextStyle(fontSize: 20)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
