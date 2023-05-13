part of 'meme_bloc.dart';

@immutable
abstract class MemeState {}

class MemeInitial extends MemeState {}

class MemeFetchingState extends MemeState {}

class MemeFetchedState extends MemeState {
  // final List<MemeModel> memeList;

  final List<SwipeItem> memeList;
  final MatchEngine matchEngine;
  MemeFetchedState({
    required this.memeList,
    required this.matchEngine,
  });
}

class MemeFetchErrorState extends MemeState {
  final Failure failure;
  MemeFetchErrorState({
    required this.failure,
  });
}
