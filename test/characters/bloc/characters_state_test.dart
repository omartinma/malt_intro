// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:malt_intro/characters/characters.dart';

void main() {
  group('CharactersState', () {
    test('support value equality', () {
      final state = CharactersState();
      expect(state.copyWith(), equals(state));
    });
  });
}
