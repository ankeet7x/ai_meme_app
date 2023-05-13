import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meminder/app/constants/app_constants.dart';
import 'package:meminder/app/functions/shared_preferences_services.dart';

class FeedbackCubit extends Cubit<bool> {
  FeedbackCubit() : super(false);

  initialize() {
    bool? isFeedBackEnabled = getBool(AppConstants.showFeedBack);
    emit(isFeedBackEnabled ?? false);
  }

  updateFeedBack(bool val) {
    setBool(
      AppConstants.showFeedBack,
      val,
    );
    emit(val);
  }
}
