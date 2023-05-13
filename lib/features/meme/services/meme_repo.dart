import 'package:dartz/dartz.dart';
import 'package:meminder/core/network/failure.dart';
import 'package:meminder/features/meme/models/meme_model.dart';

abstract class MemeRepo {
  Future<Either<List<MemeModel>, Failure>> fetchMemes({
    required List<String> memeJsonFileList,
    required int currentOverallIndexOfMeme,
    bool refetch = false,
  });
}
