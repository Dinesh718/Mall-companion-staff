import 'package:flutter/foundation.dart';

@immutable
sealed class StoreProfileEvent {
  const StoreProfileEvent();
}

class LoadStoreProfile extends StoreProfileEvent {
  const LoadStoreProfile();
}

class RefreshStoreProfile extends StoreProfileEvent {
  const RefreshStoreProfile();
}
