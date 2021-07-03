// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:character_repository/character_repository.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:malt_intro/characters/characters.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/rick_and_morty_api.dart';

class MockCategoryRepository extends Mock implements CharacterRepository {}

void main() {
  group('CharactersBloc', () {
    late CharacterRepository characterRepository;
    late CharactersBloc characterBloc;

    setUp(() {
      characterRepository = MockCategoryRepository();
      characterBloc = CharactersBloc(
        characterRepository: characterRepository,
      );
    });

    test('initial state is empty', () {
      expect(
        characterBloc.state,
        equals(CharactersState()),
      );
    });

    group('CharactersFetchRequested', () {
      const characters = [
        Character(
          name: 'name',
          id: 1,
          image: 'image',
        )
      ];

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, failure] when CharactersFetchRequested fails',
        build: () {
          when(
            () => characterRepository.getCharacters(),
          ).thenThrow(Exception());
          return characterBloc;
        },
        act: (bloc) => bloc.add(CharactersFetchRequested()),
        expect: () => [
          CharactersState(status: CharactersStatus.loading),
          CharactersState(status: CharactersStatus.failure),
        ],
      );

      blocTest<CharactersBloc, CharactersState>(
        'emits [loading, successful] when CharactersFetchRequested success',
        build: () {
          when(
            () => characterRepository.getCharacters(),
          ).thenAnswer((_) async => characters);
          return characterBloc;
        },
        act: (bloc) => bloc.add(CharactersFetchRequested()),
        expect: () => [
          CharactersState(status: CharactersStatus.loading),
          CharactersState(
            status: CharactersStatus.success,
            characters: characters,
          ),
        ],
      );
    });
  });
}
