import 'package:flutter/material.dart';

class GetInfoPage extends StatefulWidget {
  const GetInfoPage({super.key});

  @override
  State<GetInfoPage> createState() => _GetInfoPageState();
}

class _GetInfoPageState extends State<GetInfoPage> {
  @override
  Widget build(BuildContext context) {
    // return Card(
    //   shape: BeveledRectangleBorder(
    //     borderRadius: BorderRadius.circular(20),
    //     side: BorderSide(width: 100),
    //   ),
    //   child: Text('Teste'),
    // );
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
