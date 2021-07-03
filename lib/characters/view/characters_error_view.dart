import 'package:flutter/material.dart';

class CharactersErrorView extends StatelessWidget {
  const CharactersErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Oops, something went wrong'),
    );
  }
}
