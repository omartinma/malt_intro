// ignore_for_file: prefer_const_constructors
import 'package:malt_intro/characters/characters.dart';
import 'package:test/test.dart';

void main() {
  group('CharactersEvent', () {
    group('CharactersFetchRequested', () {
      test('support value equality', () {
        final instanceA = CharactersFetchRequested();
        final instanceB = CharactersFetchRequested();
        expect(instanceA, equals(instanceB));
      });
    });
  });
}
