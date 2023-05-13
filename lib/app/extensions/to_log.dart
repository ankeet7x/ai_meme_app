import 'dart:developer';

import 'package:flutter/foundation.dart';

debugLog(Object object) {
  if (kDebugMode) {
    log(
      object.toString(),
    );
  }
}
