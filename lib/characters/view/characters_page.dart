import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malt_intro/characters/characters.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage(child: CharactersPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(
        characterRepository: context.read<CharacterRepository>(),
      )..add(CharactersFetchRequested()),
      child: const CharactersView(),
    );
  }
}

class CharactersView extends StatelessWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          switch (state.status) {
            case CharactersStatus.failure:
              return const CharactersErrorView();
            case CharactersStatus.loading:
              return const CharactersLoadingView();
            case CharactersStatus.success:
              return CharactersLoadedView(characters: state.characters);
          }
        },
      ),
    );
  }
}
