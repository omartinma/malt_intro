// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:character_repository/character_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:malt_intro/characters/characters.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/helpers.dart';

class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

class FakeCharactersEvent extends Fake implements CharactersEvent {}

class FakeCharactersState extends Fake implements CharactersState {}

void main() {
  group('CharactersPage', () {
    test('is routable', () {
      expect(CharactersPage.page(), isA<MaterialPage>());
    });

    testWidgets('displays a CharactersView', (tester) async {
      await tester.pumpApp(
        CharactersPage(),
      );
      await tester.pump();
      expect(find.byType(CharactersView), findsOneWidget);
    });
  });

  group('CharactersView', () {
    late CharactersBloc charactersBloc;

    setUp(() {
      registerFallbackValue<CharactersEvent>(FakeCharactersEvent());
      registerFallbackValue<CharactersState>(FakeCharactersState());
      charactersBloc = MockCharactersBloc();
      when(() => charactersBloc.state).thenReturn(CharactersState());
    });

    testWidgets('displays CharactersErrorView when there is an error',
        (tester) async {
      when(() => charactersBloc.state).thenReturn(
        CharactersState(status: CharactersStatus.failure),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: charactersBloc,
          child: CharactersView(),
        ),
      );
      await tester.pump();
      expect(find.byType(CharactersErrorView), findsOneWidget);
    });

    testWidgets('displays CharactersLoadedView when loads correctly',
        (tester) async {
      when(() => charactersBloc.state).thenReturn(
        CharactersState(
          status: CharactersStatus.success,
          characters: const [Character(id: 1, name: 'name', image: 'image')],
        ),
      );
      await tester.pumpApp(
        BlocProvider.value(
          value: charactersBloc,
          child: CharactersView(),
        ),
      );
      await tester.pump();
      expect(find.byType(CharactersLoadedView), findsOneWidget);
    });
  });
}
