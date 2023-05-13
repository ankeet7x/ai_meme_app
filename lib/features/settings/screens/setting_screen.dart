import 'package:flutter/material.dart';
import 'package:meminder/app/constants/app_constants.dart';
import 'package:meminder/app/functions/feedback_cubit/feedback_cubit.dart';
import 'package:meminder/app/functions/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meminder/app/functions/shared_preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  static const String pageUrl = "/settings-screen";
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(children: [
        BlocBuilder<FeedbackCubit, bool>(
          builder: (context, state) {
            return SwitchListTile(
              title: const Text("Vibrate on swipe"),
              value: state,
              onChanged: (bool val) {
                BlocProvider.of<FeedbackCubit>(context).updateFeedBack(val);
                setBool(
                  AppConstants.showFeedBack,
                  val,
                );
              },
            );
          },
        )
      ]),
    );
  }
}
