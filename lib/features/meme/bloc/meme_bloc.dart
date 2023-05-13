import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meminder/app/constants/app_constants.dart';
import 'package:meminder/app/extensions/to_log.dart';
import 'package:meminder/app/functions/service_locator.dart';
import 'package:meminder/app/functions/shared_preferences_services.dart';
import 'package:meminder/core/network/failure.dart';
import 'package:meminder/features/meme/models/meme_model.dart';
import 'package:meminder/features/meme/services/meme_repo.dart';
import 'package:meminder/features/meme/widgets/meme_widget.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  final MemeRepo _repo;

  List<SwipeItem> memes = [];
  int currentOverallIndexOfMeme = 0;
  List<String> memeFileList = [];

  late MatchEngine matchEngine;
  MemeBloc(this._repo) : super(MemeInitial()) {
    on<MemesFetchEvent>((event, emit) async {
      if (state is! MemeFetchedState) {
        emit(MemeFetchingState());
        await Future.delayed(const Duration(seconds: 2));
      }
      final response = await _repo.fetchMemes(
        memeJsonFileList: memeFileList,
        currentOverallIndexOfMeme: currentOverallIndexOfMeme,
        refetch: event.isRefetch,
      );
      emit(
        response.fold((l) {
          if (event.isRefetch) {
            List<SwipeItem> currentlyRemainingMemes = List.from(memes);
            currentlyRemainingMemes.addAll(l
                .map(
                  (e) => SwipeItem(
                      content: MemeWidget(
                        meme: e,
                      ),
                      likeAction: () {
                        debugLog("Liked");
                      },
                      nopeAction: () {
                        debugLog("UnLiked");
                      },
                      onSlideUpdate: (SlideRegion? region) async {
                        debugLog(region.toString());
                      },
                      superlikeAction: () {
                        debugLog("Super liked");
                      }),
                )
                .toList());
            memes = currentlyRemainingMemes;
          } else {
            memes = l
                .map(
                  (e) => SwipeItem(
                      content: MemeWidget(
                        meme: e,
                      ),
                      likeAction: () {
                        debugLog("Liked");
                      },
                      nopeAction: () {
                        debugLog("UnLiked");
                      },
                      onSlideUpdate: (SlideRegion? region) async {
                        debugLog(region.toString());
                      },
                      superlikeAction: () {
                        debugLog("Super liked");
                      }),
                )
                .toList();
          }

          matchEngine = MatchEngine(
            swipeItems: memes,
          );
          return MemeFetchedState(
            memeList: memes,
            matchEngine: matchEngine,
          );
        }, (r) => MemeFetchErrorState(failure: r)),
      );
    });

    on<RemoveMemeFromListEvent>((event, emit) async {
      List<SwipeItem> newList = List.from(memes);
      newList.removeAt(event.index - 1);
      memes = newList;
      int newIndex = currentOverallIndexOfMeme + 1;
      setString(AppConstants.currentOverallIndexOfMeme, newIndex.toString());
      currentOverallIndexOfMeme = newIndex;
      debugLog("Current overall index of meme is $currentOverallIndexOfMeme");
      emit(
        MemeFetchedState(
          memeList: memes,
          matchEngine: MatchEngine(
            swipeItems: memes,
          ),
        ),
      );
      if (memes.length < 3) {
        locator<MemeBloc>().add(
          MemesFetchEvent(
            isRefetch: true,
          ),
        );
      }
    });

    on<MemeResetEvent>((event, emit) async {
      emit(MemeInitial());
    });

    on<ReadMemeJsonFilesEvent>((event, emit) async {
      String? currentMemeIndex =
          getString(AppConstants.currentOverallIndexOfMeme) ?? "0";
      currentOverallIndexOfMeme = int.parse(currentMemeIndex);
      final manifestJson = await rootBundle.loadString("AssetManifest.json");
      final Map<String, dynamic> manifestMap = json.decode(manifestJson);
      manifestMap.keys.forEach((element) {
        if (element.toString().endsWith(".json")) memeFileList.add(element);
      });
      debugLog("The meme files are loaded successfully.");
    });
  }
}
