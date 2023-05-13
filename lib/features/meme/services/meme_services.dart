import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meminder/app/extensions/to_log.dart';
import 'package:meminder/core/network/base_client.dart';
import 'package:meminder/features/meme/models/meme_model.dart';
import 'package:meminder/core/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:meminder/features/meme/services/meme_repo.dart';

class MemeServices extends MemeRepo {
  final NetworkBaseClient _client;
  MemeServices(this._client);

  @override
  Future<Either<List<MemeModel>, Failure>> fetchMemes(
      {required List<String> memeJsonFileList,
      required int currentOverallIndexOfMeme,
      bool refetch = false}) async {
    try {
      List<MemeModel> fetchedMemes = [];
      int indexOfFileToBeLoaded =
          getIndexOfFileToBeLoaded(currentOverallIndexOfMeme, refetch);
      debugLog("Loading $indexOfFileToBeLoaded file");
      final String memeString =
          await rootBundle.loadString(memeJsonFileList[indexOfFileToBeLoaded]);
      List<dynamic> jsonMemes = jsonDecode(memeString) as List<dynamic>;
      for (Map<String, dynamic> meme in jsonMemes) {
        fetchedMemes.add(MemeModel.fromJson(meme));
      }
      return Left(fetchedMemes);
    } catch (e) {
      return Right(Failure.fromJson({}));
    }
  }
}

getIndexOfFileToBeLoaded(int currentOverallIndexOfMeme, bool refetch) {
  return !refetch
      ? ((currentOverallIndexOfMeme) / 5).floor()
      : ((currentOverallIndexOfMeme + 2) / 5).floor();
}
