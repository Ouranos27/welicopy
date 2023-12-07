import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:weli/util/logger.dart';

class Crashlytics {
  Crashlytics.init() {
    debugConsoleLog("Crashlytic init");

    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode || kProfileMode);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  }
}

