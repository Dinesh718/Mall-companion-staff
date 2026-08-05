import 'package:flutter/foundation.dart';

@immutable
sealed class SplashEvent {
  const SplashEvent();
}

class SplashInitEvent extends SplashEvent {
  const SplashInitEvent();
}
