import 'package:flutter/material.dart';

class CardNavToPage extends StatelessWidget {
  const CardNavToPage(
      {super.key, required this.nomeDaPage, required this.page});
  final double alturaContainer = 80;
  final String nomeDaPage;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: alturaContainer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          child: Text(
            nomeDaPage,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => page,
            ),
          ),
        ),
      ),
    );
  }
}
