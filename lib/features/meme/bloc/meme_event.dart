part of 'meme_bloc.dart';

@immutable
abstract class MemeEvent {}

class MemesFetchEvent extends MemeEvent {
  final bool isRefetch;
  MemesFetchEvent({
    this.isRefetch = false,
  });
}

class MemeResetEvent extends MemeEvent {}

class RemoveMemeFromListEvent extends MemeEvent {
  final int index;
  RemoveMemeFromListEvent({
    required this.index,
  });
}

class ReadMemeJsonFilesEvent extends MemeEvent {}
