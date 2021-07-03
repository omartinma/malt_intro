import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';

class CharactersLoadedView extends StatelessWidget {
  const CharactersLoadedView({
    Key? key,
    required this.characters,
  }) : super(key: key);

  final List<Character> characters;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => CharacterItemView(
        character: characters[index],
      ),
      itemCount: characters.length,
    );
  }
}

class CharacterItemView extends StatelessWidget {
  const CharacterItemView({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.network(character.image)),
          Expanded(child: Text(character.name)),
        ],
      ),
    );
  }
}
