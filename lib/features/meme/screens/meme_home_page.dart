import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meminder/app/constants/asset_source.dart';
import 'package:meminder/app/extensions/to_log.dart';
import 'package:meminder/app/functions/images/image_functions.dart';
import 'package:meminder/app/functions/service_locator.dart';
import 'package:meminder/app/widgets/network_image_holder.dart';
import 'package:meminder/features/meme/bloc/meme_bloc.dart';
import 'package:meminder/features/meme/widgets/meme_widget.dart';
import 'package:meminder/features/settings/screens/setting_screen.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'dart:math' as math;
import 'package:swipe_cards/swipe_cards.dart';

class MemeHomePage extends StatefulWidget {
  static const String pageUrl = "/meme-home-page";
  const MemeHomePage({super.key});

  @override
  State<MemeHomePage> createState() => _MemeHomePageState();
}

class _MemeHomePageState extends State<MemeHomePage> {
  late MatchEngine _matchEngine;
  final ValueNotifier<bool> _stackIsFinished = ValueNotifier(false);

  @override
  void initState() {
    locator<MemeBloc>().add(MemesFetchEvent());
    super.initState();
  }

  double getSectionHeight() {
    return (0.2.sh - kToolbarHeight) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MemeBloc, MemeState>(
          builder: (context, state) {
            if (state is MemeFetchingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MemeFetchErrorState) {
              return Center(
                child: Text(state.failure.message!),
              );
            } else if (state is MemeFetchedState) {
              return Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _stackIsFinished,
                    builder: (BuildContext context, bool isStackFinished,
                        Widget? child) {
                      return isStackFinished
                          ? const Center(
                              child: Text(
                                "NO MORE MEMES LOL",
                              ),
                            )
                          : Container(
                              height: 0.7.sh,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 10,
                                    blurRadius: 7,
                                    offset: const Offset(
                                      0,
                                      8,
                                    ), // changes posjition of shadow
                                  ),
                                ],
                              ),
                              child: SwipeCards(
                                likeTag: Transform.rotate(
                                  angle: (-50 * math.pi) / 180,
                                  child: Image.asset(
                                    AssetSource.laughing,
                                    height: 0.1.sh,
                                  ),
                                ),
                                nopeTag: Transform.rotate(
                                  angle: (50 * math.pi) / 180,
                                  child: Image.asset(
                                    AssetSource.vomiting,
                                    height: 0.1.sh,
                                  ),
                                ),
                                upSwipeAllowed: false,
                                matchEngine: state.matchEngine,
                                itemChanged: (SwipeItem item, int index) {
                                  // memeList.removeAt(index - 1);
                                  locator<MemeBloc>().add(
                                    RemoveMemeFromListEvent(index: index),
                                  );
                                },
                                key: UniqueKey(),
                                onStackFinished: () {
                                  _stackIsFinished.value = true;
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return state.memeList[index].content;
                                },
                              ),
                            );
                    },
                  ),
                  const Expanded(
                    child: SizedBox(),
                  )
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
